rm -rf .git
git init
rm -rf wordpress
git submodule add -b 4.0-branch https://github.com/WordPress/WordPress.git wordpress
git remote rm origin

echo "install Ruby dependencies"
bundle install

echo "Install php packages via composer"
composer install

git add -A
git commit -m "Inital commit"
