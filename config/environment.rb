# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Bot.connection
Sentence.connection

# loop do
#   sleep(5.seconds)
#   Bot.generate_tweet
# end
def initialize_trumpo
  tweets = Bot.fetch_some_tweets 100
  Bot.markov_tweets (tweets)

  sentences = save_some_sentences 188
  markov_some_sentences 185

end

def average_string array
  num_array=[]
  array.each do |str|
    num_array.push(str.length)
  end
  num_array.reduce(:+)/num_array.length
end
