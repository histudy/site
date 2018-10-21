#!/bin/bash

set -e

echo "**** set readonly directory ****"
WORKING_DIR=$(dirname $0)
readonly WORKING_DIR
cd ${WORKING_DIR}

echo "**** make public and node_modules directory ****"
mkdir -p public
mkdir -p node_modules

if [ ! -e node_modules/.bin/hexo ]; then
  echo "**** install npm ****"
  npm install
fi

if [ ! -e public/.git ]; then
  if [ -e .git/worktrees ]; then
    echo "**** prune worktree ****"
    git worktree prune
  fi
  echo "**** add worktree ****"
  git worktree add public master
fi

echo "**** commit base ****"
COMMIT_MESSAGE=$(date "+Site updated: %Y-%m-%d %H:%M:%S")
git add -A
git commit -m "$COMMIT_MESSAGE"
git push --allow-unrelated-histories

echo "**** hexo generate ****"
hexo generate --force

echo "**** commit public ****"
cd public
git add -A
git commit -m "$COMMIT_MESSAGE"
git push --allow-unrelated-histories
