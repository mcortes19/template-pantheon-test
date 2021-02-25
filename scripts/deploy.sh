#!/usr/bin/env bash
BRANCH=$1
MESSAGE=$2
REPO=$PANTHEON_GIT_REPO
BUILDFOLDER=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1`
CLONEFOLDER=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1`
mv web $BUILDFOLDER
git clone --branch $BRANCH $REPO $CLONEFOLDER || git clone $REPO $CLONEFOLDER
cd $CLONEFOLDER
git branch $BRANCH ; git checkout $BRANCH
shopt -s extglob
rm -rf ./!(.git|.|..)
cd ../
composer install --no-dev --ignore-platform-reqs
find ./web/modules/contrib/ -name ".git" -exec rm -rf {} \;
find ./web/themes/contrib/ -name ".git" -exec rm -rf {} \;
find ./web/sites/all/assets/vendor/ -name ".git" -exec rm -rf {} \;
find ./web/libraries/ -name ".git" -exec rm -rf {} \;
find ./web/sites/all/libraries/ -name ".git" -exec rm -rf {} \;
rm -rf ./web/sites/default/files
cp -r web $CLONEFOLDER/
mv vendor $CLONEFOLDER/
cp pantheon.yml $CLONEFOLDER/
cp composer.json $CLONEFOLDER/
cp composer.lock $CLONEFOLDER/
cd $CLONEFOLDER
# Change CUSTOMTHEME by your own theme folder.
if [ -f ./themes/custom/CUSTOMTHEME/package.json ]; then
  cd ./themes/custom/CUSTOMTHEME
  if [ ! -d ./node_modules ]; then npm install; fi
  npm run build
  cd ../../../
fi
git add --all .
git commit -m "$MESSAGE"
git push origin $BRANCH
cd ../
rm -rf $CLONEFOLDER
rm -rf web
mv $BUILDFOLDER web
git checkout -- composer.lock
composer install --ignore-platform-reqs
git checkout -- composer.lock