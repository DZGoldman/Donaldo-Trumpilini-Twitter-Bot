desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  'testing test'
end

task :send_tweet=> :environment do
  if Time.now.hour%2==0
    Bot.generate_tweet
  end
end
