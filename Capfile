load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do

  task :fixlinks, :roles => :app do
    run "cd ~/rails/estate/current/public;unlink ./property_photos/;ln -s ~/rails/estate/estate_database/property_photos/ ./property_photos"
  end


end