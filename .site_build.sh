#!/usr/bin/env bash
set -o errexit -o nounset

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

# Replace current build version and date
CURRENT_VERSION=$(git log --pretty=format:'%h' -n 1)
CURRENT_DATE=$(git show -s --format=%ci $CURRENT_VERSION)
echo $CURRENT_VERSION "@" $CURRENT_DATE
sed -i "s/@@VERSION@@/$CURRENT_VERSION/g" site/index.html
sed -i "s/@@TIMESTAMP@@/$CURRENT_DATE/g" site/index.html
