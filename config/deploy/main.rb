default_run_options[:pty] = true
ssh_options[:forward_agent] = true

load 'config/deploy/recipes/base.rb'

set_default(:application, "unknown")
set_default(:repository, "unknown")
set_default(:branch, "master")
set_default(:scm, :git)
set_default(:user, "deployer")

set :use_sudo, false

after "deploy", "deploy:cleanup"