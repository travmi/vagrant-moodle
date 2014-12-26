#!/usr/bin/env bash

# This script syncs your moodle directory to /var/www so you can perform development testing.

rsync -drvlp --delete --exclude config.php /vagrant/moodle/src/* /var/www/local/moodle.local.lan/htdocs/
chown -R apache:apache /var/www/local
