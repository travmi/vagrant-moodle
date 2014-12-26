#!/usr/bin/env bash

# This script syncs your moodle directory to /var/www so you can perform development testing.
# Rsync source is a folder placed in the root of the project and then rsync over to /var/www.

rsync -drvlp --delete --exclude config.php /vagrant/moodle/src/* /var/www/local/moodle.local.lan/htdocs/
chown -R apache:apache /var/www/local
