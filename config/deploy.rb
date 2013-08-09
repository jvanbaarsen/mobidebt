require "bundler/capistrano"

load 'config/deploy/main'
load 'config/deploy/recipes/nginx'
load 'config/deploy/recipes/unicorn' 	# Only necassary if you use unicorn (please do :-) )

server "37.139.8.130", :app, :web, :db, :primary => true # Can be IP or FQDN

set :application, 'mobidebt' # e.g. set :application, 'mysuperapp'
set :repository, "git@github.com:jvanbaarsen/mobidebt.git"							# e.g. set :application, 'git@github.com:jvanbaarsen/deploy.git'
set :deploy_to, "/var/www/mobidebt"					# e.g. set :deploy_to, "/var/www/mysuperapp"

