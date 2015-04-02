#!/bin/bash

service mysql start
mysql -e "create database current; create database migration"
mysqldump -h $DB_HOST_NAME -u $DB_USERNAME --password=$DB_PASSWORD epiquest | mysql current
python /usr/share/EpiQuest_py/manage.py migrate
python /usr/share/EpiQuest_py/analysis/migrate_to_EG.py

unset DB_HOST_NAME
unset DB_USERNAME
unset DB_PASSWORD
