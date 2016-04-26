# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Bot.connection
Sentence.connection
#
# # loop do
# #   sleep(5.seconds)
# #   Bot.generate_tweet
# # end
# def initialize_test
#   tweets = fetch_some_tweets 100
#   Bot.markov_tweets (tweets)
#   sentences = save_some_sentences 188
#   markov_some_sentences 185
# end
#
# def initialize_full
#   trump_tweets = fetch_all_tweets
#   Bot.markov_tweets (trump_tweets)
#   save_all_sentences
#   markov_some_sentences 2700
# end
#
# def average_string array
#   num_array=[]
#   array.each do |str|
#     num_array.push(str.length)
#   end
#   num_array.reduce(:+)/num_array.length
# end
#
# def collect_with_max_id(collection=[], max_id=nil, &block)
#   response = yield max_id
#   collection += response
#   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
# end
#
# def fetch_all_tweets
#   collect_with_max_id do |max_id|
#     options = {:count => 200, :include_rts => false}
#     options[:max_id] = max_id unless max_id.nil?
#     CLIENT.user_timeline('realDonaldTrump', options)
#   end
# end
#
# def fetch_some_tweets n
#   collect_with_max_id do |max_id|
#     options = {:count => 200, :include_rts => false}
#     options[:max_id] = n unless max_id.nil?
#     CLIENT.user_timeline('realDonaldTrump', options)
#   end
# end
#
# def chain_test db_words
#   counter=0
#   not_found_words=[]
#   db_words.each_with_index do |db_word, index|
#     db_word.chain.each do |word|
#       if Word.where(word: word)[0]==nil
#         counter+=1
#         not_found_words.push(word)
#       end
#     end
#
#   end
#   not_found_words
# end
#
#
#   puts 'starting stream...'
  # loop do
  #   Bot.start_stream
  #   puts 'something has gone wrong: waiting 1 minute'
  #   sleep(1.minute)
  # end
