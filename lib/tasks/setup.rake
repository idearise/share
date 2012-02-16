task :setup => ['db:drop', 'db:create', 'db:migrate','db:seed']

task :setup_heroku => [:environment, 'db:migrate','db:seed']