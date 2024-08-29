#!/bin/bash

# Start MySQL
service mysql start

# Start Apache in the foreground
apachectl -D FOREGROUND
