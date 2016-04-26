desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  'testing test'
end

task :send_tweet=> :environment do
  puts 'sending tweet'
end
