# Mise en ligne du site de Sophie Fressingeas

## Organisation du dossier
- `docs/`    : le nouveau site (fichiers statiques publiés par GitHub Pages)
- `archive/` : copie intégrale de l'ancien site (référence, ne pas publier ailleurs)

## Étape 1 — Dépôt GitHub (une seule fois)
1. Se connecter sur https://github.com (créer un compte gratuit si besoin).
2. Créer un dépôt : bouton « New repository », nom `site-sophie`, **Public**, sans README/.gitignore, puis « Create repository ».
3. Envoyer le site depuis ce dossier (remplacer `UTILISATEUR`) :
   git remote add origin https://github.com/UTILISATEUR/site-sophie.git
   git push -u origin main
   (une fenêtre de connexion GitHub s'ouvre dans le navigateur la première fois)

## Étape 2 — Activer GitHub Pages
Dans le dépôt : Settings → Pages → « Build and deployment » :
- Source : **Deploy from a branch**
- Branch : **main**, dossier **/docs** → Save
Le site est visible après 1-2 minutes sur https://UTILISATEUR.github.io/site-sophie/

## Étape 3 — Brancher le nom de domaine sophiefressingeas-jmv.com
Chez le registrar du domaine (là où il est géré), dans la zone DNS :
- `www`  → enregistrement **CNAME** vers `UTILISATEUR.github.io`
- domaine nu `@` → 4 enregistrements **A** : 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
Puis dans GitHub : Settings → Pages → Custom domain : `www.sophiefressingeas-jmv.com` → Save,
et cocher **Enforce HTTPS** quand la case devient disponible (jusqu'à 24 h de propagation).

## Mettre à jour le site ensuite
- La cliente passe par **Pages CMS** (https://app.pagescms.org) : voir `docs-admin/MODE-D-EMPLOI.md`.
  La configuration de l'interface est dans `.pages.yml` (racine du dépôt).
- En ligne de commande, modifier les fichiers dans `docs/`, puis :
   git add -A
   git commit -m "Description de la modification"
   git push
  GitHub Pages reconstruit le site (Jekyll) en 1-2 minutes.

## Structure technique (Jekyll, construit par GitHub Pages)
- `docs/_config.yml`     : réglages (url, baseurl, version des assets `assets_version` à incrémenter
                           quand on modifie css/js, extensions jekyll-redirect-from et jekyll-sitemap)
- `docs/_layouts/`       : gabarits (default, page, article, categorie, contact, home)
- `docs/_includes/`      : en-tête, menu, bandeau, pied de page, formulaire Formspree, galeries...
- `docs/_articles/`      : un fichier par article ; l'adresse = chemin du fichier (actualites/allergie.html -> /actualites/allergie/)
- `docs/_data/infos.yml` : téléphone, e-mail, horaires, identifiant Formspree...
- `docs-admin/INVENTAIRE-URLS.tsv` : correspondance entre chaque ancienne URL et son fichier source
- `docs-admin/verifier.pl`         : contrôles sans Jekyll (perl docs-admin/verifier.pl)

## Basculement sur le nom de domaine
Dans `docs/_config.yml`, mettre `url: "https://www.sophiefressingeas-jmv.com"` et `baseurl: ""`,
puis commit + push. Rien d'autre à changer : tous les liens sont construits avec relative_url.

## Reste à configurer
- Formulaires de contact : créer un compte gratuit sur https://formspree.io avec l'adresse
  sophie.fressingeas33@gmail.com, créer un formulaire, puis reporter son identifiant dans
  `docs/_data/infos.yml` (champ `formspree_id`, ou via Pages CMS > Paramètres).
