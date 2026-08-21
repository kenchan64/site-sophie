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
Modifier les fichiers dans `docs/`, puis :
   git add -A
   git commit -m "Description de la modification"
   git push
Le site en ligne se met à jour en 1-2 minutes.

## Reste à configurer
- Formulaire de contact : créer un compte gratuit sur https://formspree.io, créer un formulaire,
  puis remplacer `VOTRE_ID` dans les pages concernées (contact.html, rendez-vous, rappel gratuit, demande d'information, pages secteur).
- Adresse e-mail : remplacer `contact@sophiefressingeas-jmv.com` par la vraie adresse.
