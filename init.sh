#!/bin/bash
# @author: David Lonjon
# http://davidlonjon.com
# Created:   29/10/2014
# Modified:   29/10/2014

ORIGIN='git config --get remote.origin.url'

echo "Adding upstream git@github.com:davidlonjon/wp-deploy.git"
git remote add upstream git@github.com:davidlonjon/wp-deploy.git

echo "Please specify the new origin for this repo?"
read NEW_ORIGIN

git remote set-url origin $NEW_ORIGIN

echo "The origin has been set to $NEW_ORIGIN"
