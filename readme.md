mina-faye
============

mina-faye is a gem that adds tasks to help the deployment of Faye
using [Mina] (http://nadarei.co/mina).
This gem based on [mina-sidekiq gem] (https://github.com/Mic92/mina-sidekiq) by [Mic92] (https://github.com/Mic92)
# Getting Start

## Installation

    gem install mina-faye

## Example

## Usage example

    require 'mina_faye/tasks'
    ...
    # to make logs persistent between deploys
    set :faye_config, "faye.ru"

    task :setup do
      # faye needs a place to store its pid file
      queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
    end

    task :deploy do
      deploy do
        # stop accepting new workers
        invoke :'git:clone'
        invoke :'deploy:link_shared_paths'
        ...

        to :launch do
          ...
          invoke :'faye:restart'
        end
      end
    end

## Available Tasks

* faye:stop
* faye:start
* faye:restart


## Available Options

| Option              | Description                                                                    |
| ------------------- | ------------------------------------------------------------------------------ |
| *faye\_config*      | Sets the path to faye config file.                                             |
| *faye\_pid*         | Sets the path to the pid file of a faye server.                                |

## Testing

The test requires a local running ssh server with the ssh keys of the current
user added to its `~/.ssh/authorized_keys`. In OS X, this is "Remote Login"
under the Sharing pref pane.

To run the full blown test suite use:

    bundle exec rake test

For faster release cycle use

    cd test_env
    bundle exec mina deploy --verbose
