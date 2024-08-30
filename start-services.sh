#!/bin/bash


# Start Apache in the foreground
apachectl -D FOREGROUND & service mysql start

# Start MySQL
#service mysql start

