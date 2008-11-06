set :application, "estate"
set :repository,  "/Users/bojicas/workspace/rubyspace/businessspace/estate"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/dineinua/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :user, "dineinua"

role :app, "your app-server here"
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true