namespace :install do
  task :user => :environment do
    ask('New user e-mail')
  end
end
