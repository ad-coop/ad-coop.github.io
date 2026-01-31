# adcoop.fr

Site web professionnel d'AD COOP, construit avec [Hugo](https://gohugo.io/).

## Prérequis

- [Docker](https://docs.docker.com/get-docker/) et Docker Compose
- Make (optionnel, mais recommandé)

## Développement local

### Avec Make (recommandé)

```bash
# Lancer le serveur de développement (http://localhost:1313)
make serve

# Obtenir un shell interactif avec Hugo
make shell

# Reconstruire l'image Docker
make build

# Nettoyer les images Docker
make clean
```

### Sans Make

```bash
# Générer le fichier .env (nécessaire une seule fois)
echo "HUGO_VERSION=$(cat .hugo-version)" > .env

# Lancer le serveur de développement
docker compose up hugo

# Obtenir un shell interactif
docker compose run --rm shell
```

### Commandes Hugo utiles

Une fois dans le shell (`make shell`), vous pouvez utiliser Hugo directement :

```bash
# Créer un nouveau contenu
hugo new content/posts/mon-article.md

# Construire le site (génère dans /public)
hugo

# Construire avec minification
hugo --minify
```

## Gestion de la version Hugo

La version de Hugo est centralisée dans le fichier `.hugo-version`. Ce fichier est utilisé par :

- Le **Makefile** pour le développement local
- Les **GitHub Actions** pour le déploiement

Pour mettre à jour Hugo :

```bash
echo "0.140.0" > .hugo-version
make build  # Reconstruire l'image Docker
```

## Déploiement

Le site est automatiquement déployé sur GitHub Pages lors d'un push sur la branche `main`.

### Workflow GitHub Actions

Le fichier `.github/workflows/hugo.yaml` définit le pipeline de déploiement :

1. **Checkout** : Récupère le code source avec les sous-modules (thème)
2. **Lecture de la version Hugo** : Lit `.hugo-version` pour garantir la cohérence avec le développement local
3. **Installation de Hugo** : Télécharge et installe Hugo Extended
4. **Build** : Génère le site statique avec `hugo --gc --minify`
5. **Déploiement** : Publie sur GitHub Pages

### Vérification des liens

Un workflow séparé (`.github/workflows/broken-links-check.yaml`) vérifie les liens cassés chaque lundi.

## Structure du projet

```
.
├── .hugo-version        # Version de Hugo (source unique de vérité)
├── config.yaml          # Configuration Hugo
├── content/             # Contenu du site (Markdown)
├── static/              # Fichiers statiques (images, etc.)
├── themes/adcoop/       # Thème personnalisé
├── Dockerfile           # Image Docker pour Hugo
├── docker-compose.yaml  # Services Docker (hugo, shell)
└── Makefile             # Commandes de développement
```
