# Mode d'emploi : mettre à jour mon site moi-même

Ce guide explique comment ajouter ou modifier les articles et les textes du site
**sophiefressingeas-jmv.com** sans aucune connaissance technique, grâce à l'outil gratuit
**Pages CMS**.

---

## 1. Se connecter

1. Ouvrir la page **https://app.pagescms.org** dans le navigateur (ordinateur de préférence).
2. Cliquer sur **« Sign in with GitHub »** et se connecter avec le **compte GitHub propriétaire du
   site** (identifiant et mot de passe fournis lors de la mise en ligne ; ils sont à conserver
   précieusement, c'est la clé du site).
3. La première fois, GitHub demande d'autoriser Pages CMS à accéder au dépôt : cliquer sur
   **Authorize** / **Install**, puis choisir le dépôt **site-sophie**.
4. Choisir ensuite le dépôt **site-sophie** dans la liste. Le menu de gauche apparaît :
   **Articles**, **Articles (anciennes rubriques)**, **Pages**, **Paramètres**, **Médias**.

> Conseil : ajouter https://app.pagescms.org dans les favoris du navigateur.

---

## 2. Ajouter un article (avec une photo)

1. Dans le menu de gauche, cliquer sur **Articles**, puis sur le bouton **« + Add an entry »**
   (ou **Nouveau**) en haut à droite.
2. Remplir le formulaire :
   - **Titre de l'article** : obligatoire. Il sert aussi à fabriquer l'adresse de la page
     (par exemple « Bien dormir en hiver » donnera `/actualites/bien-dormir-en-hiver/`).
   - **Date** : la date du jour est proposée. Les articles sont classés du plus récent au plus
     ancien dans le Blog, la page Actualités et le carrousel de l'accueil.
   - **Rubrique** : Actualités, Méthode JMV, Naturopathie ou Knap (c'est le filtre du Blog).
   - **Photo principale** : cliquer, puis **Upload** pour envoyer une photo depuis l'ordinateur,
     ou choisir une photo déjà présente. Format paysage conseillé (environ 1200 x 800 pixels,
     moins de 500 Ko : réduire la photo avant de l'envoyer si elle vient directement d'un appareil
     photo ou d'un téléphone).
   - **Description de la photo** : quelques mots décrivant l'image.
   - **Résumé** : 2 ou 3 phrases affichées dans les listes. Si le champ est vide, le début du
     texte est utilisé automatiquement.
   - **Texte de l'article** : le texte complet. La barre d'outils permet de mettre en gras, de
     faire des titres, des listes, des liens, d'insérer des images...
   - **Afficher la date** : laisser coché (décocher pour un texte « intemporel »).
   - **Ne pas afficher dans le Blog** : laisser décoché.
   - **Titre / Description pour Google** : facultatifs.
3. Cliquer sur **Save** (Enregistrer) en haut à droite.

L'article est enregistré sur GitHub et le site se reconstruit automatiquement : il apparaît en
ligne **au bout de 1 à 2 minutes** (parfois 5 minutes). Si la page semble inchangée, recharger
avec **Ctrl + F5** (ordinateur) ou vider le cache du navigateur (téléphone).

### Les 3 derniers articles de la rubrique « Actualités »

Ils s'affichent automatiquement dans le carrousel en haut de la page d'accueil. Il n'y a rien à
faire de particulier.

---

## 3. Modifier un article existant

1. Cliquer sur **Articles** (articles de la rubrique Actualités publiés à l'adresse
   `/actualites/...`) ou sur **Articles (anciennes rubriques)** (tous les articles, classés par
   dossier : `methode-jmv`, `methode-jmvr`, `naturopathie`, `knap`, `sophie-fressingeas`, `blog`).
2. Cliquer sur l'article à modifier, faire les changements, puis **Save**.

Les anciens articles du site ont gardé leur adresse d'origine : **ne pas les renommer ni les
déplacer** (bouton « Rename » / « Move ») pour ne pas casser les liens connus de Google.

---

## 4. Supprimer un article

1. Ouvrir l'article, puis utiliser le menu **« ... »** (en haut à droite) > **Delete**.
2. Confirmer. L'article disparaît du site après la reconstruction (1 à 2 minutes).

Autre possibilité, plus douce : cocher **« Ne pas afficher dans le Blog »** ; l'article reste
accessible par son adresse mais n'apparaît plus dans la liste.

---

## 5. Modifier le texte d'une page

Menu **Pages** : **Accueil**, **Présentation**, **Méthode JMV**, **Naturopathie**, **Knap**,
**Contact**, **Rendez-vous**, **Merci**, **Liens utiles**, **Mentions légales**.

1. Cliquer sur la page, modifier le texte dans l'éditeur, puis **Save**.
2. Sur les pages Présentation / Méthode JMV / Naturopathie / Knap, la liste
   **« Articles mis en avant en bas de page »** contient les adresses des articles affichés sous le
   texte (par exemple `/actualites/allergie/`) ; on peut en ajouter, en retirer ou changer l'ordre.
3. Sur la page **Accueil**, les 3 blocs « Méthode JMV / Naturopathie / Méthode Knap » se modifient
   dans la partie **« Les 3 spécialités (damier) »**.

Remarque : certaines pages contiennent une mise en page élaborée (colonnes, encadrés). L'éditeur
la conserve tant qu'on se contente de corriger du texte ; en cas de gros remaniement, demander
conseil au webmaster.

---

## 6. Paramètres (téléphone, e-mail, horaires...)

Menu **Paramètres** : nom, métier et ville, phrase d'accroche, téléphone, adresse e-mail, lien de
prise de rendez-vous en ligne, horaires, zone d'intervention, phrase du bandeau vert, et
**identifiant Formspree** (service qui achemine les messages des formulaires de contact vers la
boîte e-mail). Modifier, puis **Save** : toutes les pages sont mises à jour.

---

## 7. Les photos (menu Médias)

Le menu **Médias** montre toutes les images du site. On peut y envoyer des photos à l'avance
(bouton **Upload**) et créer un dossier « uploads » pour les ranger. Ne pas supprimer les images
existantes : elles sont utilisées par les pages (logo, pictogrammes, photos des articles...).

---

## 8. Ce qu'il ne faut pas toucher

- Les dossiers et fichiers qui commencent par un **tiret bas** (`_layouts`, `_includes`,
  `_config.yml`...), le dossier `css`, le dossier `js`, le fichier `.pages.yml` : c'est la
  « mécanique » du site. Ils ne sont pas visibles dans Pages CMS, et il ne faut pas les modifier
  directement sur GitHub.
- Les **adresses** (noms de fichiers) des articles et des pages existants : ne pas renommer, ne
  pas déplacer.
- Le dossier **archive/** sur GitHub (copie de l'ancien site, pour mémoire).
- Les réglages du dépôt GitHub (**Settings** > **Pages**) : ils font le lien entre le site et le
  nom de domaine.

En cas de doute ou d'erreur, pas de panique : GitHub conserve l'historique de toutes les
modifications, le webmaster peut toujours revenir en arrière.

---

## 9. En résumé

| Je veux...                         | Où ?                                   | Délai de publication |
|-----------------------------------|----------------------------------------|----------------------|
| Publier un article                | Articles > + Add an entry > Save       | 1 à 2 minutes        |
| Corriger un article               | Articles (ou anciennes rubriques)      | 1 à 2 minutes        |
| Supprimer un article              | Article > ... > Delete                 | 1 à 2 minutes        |
| Changer le texte d'une page       | Pages > la page > Save                 | 1 à 2 minutes        |
| Changer téléphone, horaires, mail | Paramètres > Save                      | 1 à 2 minutes        |
| Ajouter des photos                | Médias > Upload                        | immédiat dans le CMS |
