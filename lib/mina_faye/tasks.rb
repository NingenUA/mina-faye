
require 'mina/bundler'
require 'mina/rails'

# ## Settings

# ### Faye

# Sets the path to faye config file
set_default :faye_config, lambda { "faye.ru" }

# Sets the path to the pid file of a faye
set_default :faye_pid, lambda { "#{deploy_to}/#{shared_path}/pids/faye.pid" }

namespace :faye do
  desc "Stop Faye"
  task :stop => :environment do
    queue %[echo "-----> Stop Faye"]
    queue %[
      if [ -f #{faye_pid} ] && kill -KILL $(cat #{faye_pid})> /dev/null 2>&1; then
        cd "#{deploy_to}/#{current_path}"
        echo 'Faye stop'
       else
        echo 'Skip stopping faye (no pid file found)'
      fi
    ]
  end
  desc "Start Faye"
  task :start => :environment do
    queue %[echo "-----> Start Faye"]
    queue %{
      echo "Faye starting in #{rails_env}"
      cd "#{deploy_to}/#{current_path}"
      #{echo_cmd %[RAILS_ENV=#{rails_env} #{bundle_bin} exec nohup rackup #{faye_config} -E #{rails_env} -o 0.0.0.0 -P #{faye_pid} --daemonize ] }
          }
  end

  desc "Restart Faye"
  task :restart do
    invoke :'faye:stop'
    invoke :'faye:start'
  end
end
