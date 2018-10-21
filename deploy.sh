#!/bin/bash

set -e

WORKING_DIR=$(dirname $0)
readonly WORKING_DIR
cd ${WORKING_DIR}

mkdir -p public
mkdir -p node_modules

if [ ! -e node_modules/.bin/hexo ]; then
  npm install
fi

git pull origin master
if [ ! -e public/.git ]; then
  if [ -e .git/worktrees ]; then
    git worktree prune
  fi
  git worktree add public master
fi

COMMIT_MESSAGE=$(date "+Site updated: %Y-%m-%d %H:%M:%S")
git add -A
git commit -m "$COMMIT_MESSAGE"
git push

hexo generate --force

cd public
git add -A
git commit -m "$COMMIT_MESSAGE"
git push
