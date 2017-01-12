#!/usr/bin/env bash
set -o errexit -o nounset

# Get curent commit revision
rev=$(git rev-parse --short HEAD)

# Initialize gh-pages checkout
mkdir -p site
(
  cd site
  git init
  git config user.name "${GH_USER_NAME}"
  git config user.email "${GH_USER_EMAIL}"
  git remote add upstream "https://${GH_TOKEN}@${GH_REF}"
  git fetch upstream
  git reset upstream/gh-pages
)

# Build the documentation
mkdocs build --clean

#Commit and push the documentation to gh-pages
(
  cd site
  touch .
  git add -A .
  git commit -m "Rebuild pages at ${rev}"
  git push -q upstream HEAD:gh-pages
)
