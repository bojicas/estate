load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do

  task :fixlinks, :roles => :app do
    run "rm -f ~/rails/estate/current/public/property_photos;ln -s ~/rails/estate/estate_database/property_photos/ ~/rails/estate/current/public/property_photos"
  end


end