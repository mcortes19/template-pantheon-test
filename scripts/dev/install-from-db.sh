#!/usr/bin/env bash
if [ ! -f db_site.sql.gz ]; then
  platform db:dump --gzip --file=db_site.sql.gz -e master
fi
chirripo drush cr
echo "Drop Database..."
chirripo drush sql:drop -- -y
echo "Import database..."
chirripo db-import ./db_site.sql.gz
echo "Update database..."
chirripo drush updb -- --no-cache-clear -y
echo "Cleaning cache..."
chirripo drush cr
echo "Importing config..."
chirripo drush cim -- -y
echo "Cleaning cache..."
chirripo drush cr
echo "Sanitizing database..."
chirripo drush sqlsan -- --sanitize-password=admin -y
echo "Generating an admin one time login link..."
chirripo drush uli
