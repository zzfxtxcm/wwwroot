# coding: utf-8

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'wwwroot'
set :repo_url, 'https://github.com/zzfxtxcm/wwwroot.git'
set :branch, 'master'

set :deploy_to, '/home/wwwroot/www'
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pry, true

# files we want symlinking to specific entries in shared
# set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
set :linked_files, %w{config.ru}
#
# dirs we want symlinking to shared
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

set :keep_releases, 5

# set :rvm_type, :user
# set :rvm_ruby_version, 'ruby-2.1.0'

# SSHKit.config.command_map[:rake]  = "bundle exec rake"
# SSHKit.config.command_map[:rails] = "bundle exec rails"


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# desc 'make production database.yml link'
# task :symlink_db_yml do
#   on roles(:app) do
#     execute "ln -s #{shared_path}/config/database.yml
#             #{release_path}/config/database.yml"
#   end
# end

namespace :deploy do
  set :unicorn_config, "#{current_path}/config/unicorn.rb"
  set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -USR2 `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

  desc 'stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

  # after :publishing, :restart

  desc 'start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within "#{current_path}" do
        with rails_env: "production", bundle_gemfile: fetch(:bundle_gemfile) do
          execute :bundle, :exec, "unicorn_rails -c #{fetch(:unicorn_config)} -D"
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before 'start', 'rvm:hook'
  after :finishing, 'deploy:cleanup'

  # after 'bundler:install', :symlink_db_yml
end
