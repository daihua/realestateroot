#############################################################
#	Application
#############################################################

set :application, "realestateroot"
set :deploy_to, "/var/www/#{application}"


#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true


#############################################################
#	Servers
#############################################################

set :user, "root"
# set :domain, "75.101.159.140"
# set :domain, "204.232.203.34"
set  :domain, "173.203.127.72"
role :app, domain
role :web, domain
role :db, domain, :primary => true


#############################################################
#	Git Repository
#############################################################
set :repository,  "git@173.203.127.72:realestateroot.git"
set :scm, :git


#############################################################
#	Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  # task :bootstrap do
  #   run "cp #{deploy_to}/config/database.yml #{release_path}/config/"
  #   run "cp #{deploy_to}/releases/production.conf #{release_path}/config/ultrasphinx/"
  #   run "cd #{release_path}"
  #   sudo "apache2ctl restart"
  # end
  
  task :ultrasphinx do
    # run "rm #{deploy_to}/config/ultrasphinx/development.conf"
    run "cd #{deploy_to} && sudo RAILS_ENV=production rake ultrasphinx:bootstrap"
    run "apache2ctl restart"
  end
  
  task :update do
    run "cp #{deploy_to}/current/config/example_database.yml #{deploy_to}/current/config/database.yml"
    run "apache2ctl restart"
  end 
  
end

after :deploy, "passenger:restart"
after "deploy:update"
