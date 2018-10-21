#!/bin/bash

set -e

echo "**** set readonly directory ****"
WORKING_DIR=$(dirname $0)
readonly WORKING_DIR
cd ${WORKING_DIR}
pwd

echo "**** make public and node_modules directory ****"
mkdir -p public
mkdir -p node_modules

if [ ! -e node_modules/.bin/hexo ]; then
  echo "**** install npm ****"
  npm install
fi

echo "**** hexo generate ****"
hexo generate --force

echo "**** upload server ****"
rsync -auz --delete -e ssh ./public/ 223n@histudy.jp:/tmp/www/html/

