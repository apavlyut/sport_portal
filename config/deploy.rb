# set :application, "fit"
# set :repository,  "git@github.com:fitset/fitset.git"
# 
# # If you aren't deploying to /u/apps/#{application} on the target
# # servers (which is the default), you can specify the actual location
# # via the :deploy_to variable:
# # set :deploy_to, "/var/www/#{application}"
# 
# # If you aren't using Subversion to manage your source code, specify
# # your SCM below:
# # set :scm, :subversion
# set :scm, :git
# set :deploy_to, "/home/fitset"
# 
# set :user, 'root'
# 
# role :app, "fitset.ru"
# role :web, "fitset.ru"
# role :db,  "fitset.ru", :primary => true
# 
# namespace :deploy do
#   desc "Restarting mod_rails with restart.txt"
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
#  
#   [:start, :stop].each do |t|
#     desc "#{t} task is a no-op with mod_rails"
#     task t, :roles => :app do ; end
#   end
# end
# 


set :application, "fitset.ru"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "root"
set :deploy_to, "/home/"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:fitset/fitset.git"
set :branch, "alex"

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  desc "Sync the public/assets directory."
  task :assets do
    system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'