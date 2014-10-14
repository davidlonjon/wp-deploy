############################################
# Setup Server
############################################

set :stage, :staging
set :stage_url, "http://www.example.com"
server "XXX.XXX.XX.XXX", user: "SSHUSER", roles: %w{web app db}
set :deploy_to, "/deploy/to/path"

#set :tmp_dir, '/home/wp-dlstage/tmp' # Set a different tmp dir if staging is on same server as prod
# It is recommended not to have staging on production but when starting to test things it
# is useful

############################################
# Setup Git
############################################

set :branch, "development"