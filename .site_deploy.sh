#!/usr/bin/env bash
set -o errexit -o nounset

# Get curent commit revision
rev=$(git rev-parse --short HEAD)

# Commit and push the documentation to gh-pages
(
  cd site
  touch .
  git add -A .
  git commit -m "Rebuild pages at ${rev}"
  git push -q upstream HEAD:gh-pages
)
