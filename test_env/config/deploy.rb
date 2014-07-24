require 'mina'
require 'mina/git'
require 'mina_faye/tasks'
require 'mina/git'
require 'mina/bundler'
require 'mina/rvm'
require 'fileutils'


FileUtils.mkdir_p "#{Dir.pwd}/deploy"

set :ssh_options, '-o StrictHostKeyChecking=no'

set :domain, 'localhost'
set :deploy_to, "#{Dir.pwd}/deploy"
set :repository, 'https://github.com/NingenUA/mina_faye_rails_test.git'
set :keep_releases, 2
set :sidekiq_processes, 2

set :shared_paths, ['log']
set :term_mode, nil

task :environment do
  invoke :'rvm:use[ruby-2.1.2]'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
  queue! %[mkdir -p "#{deploy_to}/shared/log/"]
end

task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    to :launch do
      invoke :'faye:start'
      queue! %[sleep 3; kill -0 `cat #{faye_pid}`]



      invoke :'faye:stop'
      queue! %[(kill -0 `cat #{faye_pid}`) 2> /dev/null && exit 1 || exit 0]
    end
  end
end
