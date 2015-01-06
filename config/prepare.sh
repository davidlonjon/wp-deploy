function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

e_header "PREPARING THE NEW REPO"

e_arrow "Reseting git..."
rm -rf .git
git init

e_arrow "Reseting Wordpress as a submodule..."
rm -rf wordpress
git submodule add -b 4.1-branch https://github.com/WordPress/WordPress.git wordpress

e_arrow "Checkout latest Wordpress version..."
# Get new tags from remote
(cd wordpress; git fetch --tags)
# Get latest tag name
latestTag=$(cd wordpress; git describe --tags `git rev-list --tags --max-count=1`)
# Checkout latest tag
(cd wordpress; git checkout $latestTag)

if command -v bundle >/dev/null 2>&1 ; then
  e_arrow "Install Ruby dependencies"
  bundle install
else
  e_error "You do not seem to have Ruby bundle command install. Please install ruby bundle and run 'bundle install' command from the root directory"
fi

if command -v composer >/dev/null 2>&1 ; then
  e_arrow "Install php packages via composer"
  composer install
else
  e_error "You do not seem to have Composer command install. Please install composer and run 'composer install' command from the root directory"
fi

e_arrow "Making initial commit..."
git add -A
git commit -m "Initial commit"

e_arrow "Create a develop branch..."
git checkout -b develop

e_arrow "Please specify the new origin for this repo?"
read NEW_ORIGIN

if [ -z "$NEW_ORIGIN" ]; then
  e_error "The new origin is missing. You will have to add the new origin yourself"
else
  e_arrow "Set origin to $NEW_ORIGIN"
  git remote add origin $NEW_ORIGIN

  e_arrow "Push to master branch to remote"
  git push -u origin master

  e_arrow "Push to develop branch to remote"
  git push -u origin develop
fi

e_success "All setup completed"
