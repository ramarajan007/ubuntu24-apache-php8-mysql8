#!/bin/bash

# Set your MySQL root password here
MYSQL_ROOT_PASSWORD="Scremr@2k23"

# Commands to automate MySQL login and set root password
mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
