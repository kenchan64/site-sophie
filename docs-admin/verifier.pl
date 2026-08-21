#!/usr/bin/perl
# Contrôles du site Jekyll sans Ruby (à lancer depuis la racine du dépôt : perl docs-admin/verifier.pl)
#  a) en-têtes YAML (front matter) de tous les fichiers docs/ (pages + _articles)
#  b) chaque URL de l'ancien sitemap.xml correspond à un permalink, un article ou un redirect_from
#  c) pas de chemins ../ ni de {{ / {% résiduels dans les corps (hors balises include autorisées)
#  d) chaque include / layout référencé existe ; encodage UTF-8 sans BOM
use strict; use warnings; use utf8;
binmode STDOUT, ':utf8';
my $root = 'docs';
my ($err,$warn)=(0,0);
sub ko { print "ERREUR  : $_[0]\n"; $err++ }
sub ww { print "ATTENTION: $_[0]\n"; $warn++ }
sub slurp { my $f=shift; open my $fh,'<:raw',$f or die "$f: $!"; local $/; my $s=<$fh>; close $fh; $s }

my @files = sort grep { -f } map { s{\\}{/}gr } split /\n/, `git ls-files --cached --others --exclude-standard $root` ;
my (%urls, %redirects, @layouts_used, @includes_used);
my %layouts = map { s{.*/}{}r =~ s/\.html$//r => 1 } glob("$root/_layouts/*.html");
my %includes = map { s{.*/}{}r => 1 } glob("$root/_includes/*.html");
$layouts{redirect}=1; # fourni par jekyll-redirect-from

# --- mini-analyseur YAML (sous-ensemble : clé: valeur, listes « - », blocs « | », objets indentés)
sub parse_fm {
  my ($yaml,$f)=@_; my %d; my @lines = split /\n/, $yaml; my $i=0;
  while ($i < @lines) {
    my $l = $lines[$i];
    if ($l =~ /^\s*$/ || $l =~ /^\s*#/) { $i++; next }
    if ($l =~ /^([A-Za-z_][\w-]*):\s*(.*?)\s*$/) {
      my ($k,$v)=($1,$2);
      if ($v eq '') {
        # liste ou objet sur les lignes suivantes
        my @items; $i++;
        while ($i < @lines && $lines[$i] =~ /^(\s+)\S/) { push @items, $lines[$i]; $i++ }
        if (!@items) { $d{$k}=''; next }
        ko("$f : clé « $k » sans valeur ni liste") unless $items[0] =~ /^\s+-\s/;
        $d{$k} = [ map { s/^\s+-\s*//r } grep { /^\s+-\s/ } @items ];
        next;
      } elsif ($v eq '|') {
        $i++; while ($i < @lines && ($lines[$i] =~ /^\s+/ || $lines[$i] eq '')) { $i++ } $d{$k}='<bloc>'; next;
      } elsif ($v =~ /^"(.*)"$/) {
        my $s=$1; ko("$f : guillemet non échappé dans « $k »") if $s =~ /(?<!\\)"/; $d{$k}=$s =~ s/\\"/"/gr;
      } elsif ($v =~ /^[\[\{]/) { $d{$k}=$v; }
      elsif ($v =~ /[:#]\s|^[&*!%@`]|^['"]/) { ko("$f : valeur de « $k » à mettre entre guillemets : $v"); $d{$k}=$v }
      else { $d{$k}=$v }
      $i++;
    } else { ko("$f : ligne YAML non reconnue : $l"); $i++ }
  }
  \%d;
}

for my $f (@files) {
  next if $f =~ m{/(css|js|images|files)/};
  my $raw = slurp($f);
  ko("$f : BOM UTF-8 en tête de fichier") if $raw =~ /^\xEF\xBB\xBF/;
  my $s = eval { my $t=$raw; utf8::decode($t) or die; $t } // do { ko("$f : UTF-8 invalide"); next };
  ko("$f : fin de ligne Windows (CRLF)") if $s =~ /\r\n/;
  next unless $f =~ /\.(html|txt|yml)$/;
  next if $f =~ m{/_data/|_config.yml$};
  my $body = $s;
  my $fm;
  if ($s =~ /\A---\n(.*?)\n---\n(.*)\z/s) { ($fm,$body)=($1,$2); $fm = parse_fm($fm,$f); }
  elsif ($f =~ m{/_(layouts|includes)/}) { $fm = {}; }
  else { ko("$f : pas de front matter (le fichier ne serait pas traité par Jekyll)"); next }
  if ($f =~ m{/_layouts/} && $s =~ /\A---\n(.*?)\n---\n/s) { push @layouts_used, [$f, $fm->{layout}] if $fm->{layout}; }
  # layout
  if ($f !~ m{/_(layouts|includes)/}) {
    my $layout = $fm->{layout} // ($f =~ m{/_articles/} ? 'article' : 'page');
    push @layouts_used, [$f,$layout] unless $layout eq 'null';
    ko("$f : titre manquant") if $layout ne 'null' && !defined $fm->{title};
  }
  # URL produite
  if ($f =~ m{^docs/_articles/(.*)\.html$}) {
    my $u = "/$1/"; $urls{$u}=$f;
    ko("$f : champ « permalink » interdit dans un article (l'adresse vient du chemin)") if exists $fm->{permalink};
    ko("$f : date manquante") unless $fm->{date};
    ko("$f : date invalide « $fm->{date} »") if $fm->{date} && $fm->{date} !~ /^\d{4}-\d{2}-\d{2}$/;
    ko("$f : rubrique inconnue « $fm->{rubrique} »") unless ($fm->{rubrique}//'') =~ /^(Actualités|Méthode JMV|Naturopathie|Knap)$/;
  } elsif ($f !~ m{/_(layouts|includes)/}) {
    my $u = $fm->{permalink};
    if (!defined $u) { ($u = $f) =~ s{^docs}{}; $u =~ s{/index\.html$}{/}; }
    $urls{$u}=$f;
  }
  if (ref $fm->{redirect_from}) { $redirects{$_}=$f for @{$fm->{redirect_from}} }
  # includes
  push @includes_used, [$f,$1] while $s =~ /\{%-?\s*include\s+([\w.-]+)/g;
  # corps : chemins relatifs et Liquid résiduel (hors includes/layouts qui en contiennent légitimement)
  if ($f !~ m{/_(layouts|includes)/}) {
    ko("$f : chemin relatif « ../ » résiduel") if $body =~ m{(href|src|action)="(\.\./|[a-z0-9-]+/|index\.html|contact\.html)} || $body =~ m{url\(\.\./};
    my $b = $body;
    if ($f =~ m{/(blog|actualites)/index\.html$|/_articles/}) { }
    $b =~ s/\{%-?\s*include [^%]*-?%\}//g;
    $b =~ s/\{%-?\s*comment\s*-?%\}.*?\{%-?\s*endcomment\s*-?%\}//gs;
    if ($f =~ m{/_articles/} || $f =~ m{/secteur/|/naturopathie-methode-jmv/|/naturopathe-secteur/|/mentions-legales/|/sitemap/|/merci/|/liens-utiles/|/contact\.html$|/rendez-vous|/flottant|/soref|/sf/|/presentation-de|^docs/index\.html$}) {
      ko("$f : balise Liquid {{ ou {% dans le corps") if $b =~ /\{\{|\{%/;
    }
  }
}
# layouts / includes
for (@layouts_used) { ko("$_->[0] : layout « $_->[1] » introuvable") unless $layouts{$_->[1]} }
for (@includes_used) { ko("$_->[0] : include « $_->[1] » introuvable") unless $includes{$_->[1]} }

# --- URLs de l'ancien sitemap
my $old = `git show HEAD:docs/sitemap.xml 2>/dev/null`;
my @locs = $old =~ m{<loc>(.*?)</loc>}g;
my $n_ok=0; my @manq;
for my $loc (@locs) {
  (my $u = $loc) =~ s{^https?://[^/]+}{}; $u = "/$u" unless $u =~ m{^/}; $u .= "/" unless $u =~ m{/$|\.[a-z]+$};
  if ($urls{$u}) { $n_ok++ } elsif ($redirects{$u}) { $n_ok++ } else { push @manq, $u }
}
print "URLs de l'ancien sitemap : ".scalar(@locs)." ; couvertes : $n_ok\n";
ko("URL absente : $_") for @manq;
# doublons URL
my %seen; for my $u (keys %urls) { ko("URL $u produite aussi par une redirection ($redirects{$u})") if $redirects{$u} }
print "Pages/articles produits : ".scalar(keys %urls)." ; redirections : ".scalar(keys %redirects)."\n";
print "Résultat : $err erreur(s), $warn avertissement(s)\n";
exit($err ? 1 : 0);
