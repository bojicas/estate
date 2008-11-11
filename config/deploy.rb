set :application, "estate"
set :user, "dineinua"
set :repository,  "file:///home/dineinua/repos/estate/"
set :local_repository, "#{File.dirname(__FILE__)}/../"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/dineinua/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :scm_username, user
set :runner, user

set :use_sudo, false
set :group_writable, false

role :app, "dineinuae.com"
role :web, "dineinuae.com"
role :db,  "dineinuae.com", :primary => true

set :rails_env, 'development'

