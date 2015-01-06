#!/bin/bash
# @author: David Lonjon
# http://davidlonjon.com
# Created:   29/10/2014
# Modified:   29/10/2014

ORIGIN='git config --get remote.origin.url'

echo "Reseting git..."
rm -rf .git
git init

echo "Reseting wordpress as a submodule..."
rm -rf wordpress
git submodule add -b 4.0-branch https://github.com/WordPress/WordPress.git wordpress

echo "Removing origin..."
git remote rm origin

echo "Making initial commit..."
git add -A
git commit -m "Inital commit"

echo "Please specify the new origin for this repo?"
read NEW_ORIGIN

echo "Set origin to $NEW_ORIGIN"
git remote add origin $NEW_ORIGIN

echo "Push to origin"
git push origin master

echo "Add upstream git@github.com:davidlonjon/wp-deploy.git"
git remote add upstream git@github.com:davidlonjon/wp-deploy.git

echo "install Ruby dependencies"
bundle install

echo "Install php packages via composer"
composer install