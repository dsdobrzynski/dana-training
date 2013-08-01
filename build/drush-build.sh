#!/usr/bin/env bash

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done

drush="drush $drush_flags"

# can't run this on a dir shared via nfs, so non-starter for vagrant
# sudo $(dirname "$0")/file-permissions.sh --drupal_user=$USER --drupal_path=$PWD --httpd_group=www-data;

build_path=$(dirname "$0")

$drush sql-drop -y &&
# $drush sqlc < $build_path/ref_db/slaughterhouse/gc011_db.sql -y &&
# rm -rf /var/drupals/gc011/www/sites/default/files &&
# tar -zxvf $build_path/ref_db/slaughterhouse/gc011_files.tar.gz -C /var/drupals/gc011/www/sites/default/ &&
# $drush dis $(cat $build/mods_purge | tr '\n' ' ') -y &&
# $drush pm-uninstall $(cat $build/mods_purge | tr '\n' ' ') -y &&
$drush en $(cat $build/mods_enabled | tr '\n' ' ') -y &&
$drush cc all -y
# $drush fra -y &&
$drush updb -y &&
$drush cc all -y
