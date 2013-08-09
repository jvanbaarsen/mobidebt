def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
  before "deploy:cold", "deploy:check_revision"
  before "deploy:migration", "deploy:check_revision"

  desc "Check if all the values are correct"
  task :check_values do        	  
    valid = false if "#{application}" == "unknown"      
    valid = false if "#{repository}" == "unknown"         
    
    #Default deploy_to is set to /u/app/applicationname, so we have to do a weird check
    if "#{deploy_to}" == "/u/apps/#{application}"
    	puts "Please specify the deploy path, set :deploy_to, '/your/path/#{application}'"
    	exit
    end    
  end
  before "deploy", "deploy:check_values"
end