desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  'testing test'
end

task :send_tweet=> :environment do
  time = Time.now
  Bot.follow_back if time.hour == 23
  break if time.hour%2==1
  
  random = rand(1..5)
  if random>1
    Bot.generate_tweet
  elsif random==1
    friend='@'+CLIENT.friends.to_a.sample.screen_name
    tweet = "#{friend} #{Bot.generate_reply}"
    CLIENT.update(tweet)
  end

end
