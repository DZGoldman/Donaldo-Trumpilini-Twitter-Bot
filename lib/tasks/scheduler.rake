desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  'testing test'
end

task :send_tweet=> :environment do
  break if Time.now.hour%2==1
  Bot.generate_tweet
  # friend='@'+CLIENT.friends.to_a.choose.user_name
  # CLIENT.update("#{friend} #{Bot.generate_reply}")


end
