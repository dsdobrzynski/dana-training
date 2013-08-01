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

$drush si --account-pass='drupaladm1n' --db-url=mysql://dana-trainingDBA:dana-trainingPASS@localhost/dana-trainingDB --sites-subdir=default -y &&
# $drush sqlc --db-url=mysql://dana-trainingDBA:dana-trainingPASS@localhost/dana-trainingDB < /vagrant/build/ref_db/dana-training_db.sql -vd &&
$drush updb -y &&
$drush uli &&
$drush upwd --password="drupaladm1n" admin &&
chmod 775 /var/drupals/dana-training/www/sites/default &&
chmod 775 -R /var/drupals/dana-training/www/sites/default/files &&
# rm -rf /var/drupals/dana-training/www/sites/default/files &&
# tar -zxvf $build_path/ref_db/dana-training_files.tar.gz -C /var/drupals/dana-training/www/sites/default/ &&
$drush dis $(cat $build_path/mods_purge | tr '\n' ' ') -y &&
$drush pm-uninstall $(cat $build_path/mods_purge | tr '\n' ' ') -y &&
$drush en $(cat $build_path/mods_enabled | tr '\n' ' ') -y &&
$drush cc all -y &&
$drush updb -y &&
$drush cc all -y
