# 1. on part d'une image de node à la version 18-alpine
FROM node:18-alpine

# 2. Installer git
RUN apk add --no-cache git bash

# 3. Dossier de travail dans le conteneur
WORKDIR /app

# 4. Arguments pour passer l’URL et la branche au build
ARG REPO_URL=https://github.com/toptal/haste-server.git
ARG BRANCH=master

# 5. Clonage du repo
RUN git clone --depth 1 --branch "$BRANCH" "$REPO_URL" .

# 6. On copie tout les fichiers du repo
COPY . .

# 7. On installe les dépendances
RUN npm install

# 8. On change les fichiers par nos fichiers
COPY settings/index.html static/index.html

# 9. Pareil
COPY settings/config.json config.js

# 10. On expose le port 8085
EXPOSE 8085

# 11. On lance le tout
CMD ["npm", "start"]