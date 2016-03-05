class Bot < ActiveRecord::Base
  def self.collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield max_id
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def self.fetch_all_tweets
    Bot.collect_with_max_id do |max_id|
      options = {:count => 200, :include_rts => false}
      options[:max_id] = max_id unless max_id.nil?
      CLIENT.user_timeline('realDonaldTrump', options)
    end
  end

  def self.markov_tweets (tweets)
    tweets.each do |tweet|
      make_markov(tweet.full_text)
    end
  end

  def self.make_markov text
    clean_text = text.tr('"', '')
    array = text.split(' ')
    #iterate through each word
    array.each_with_index do |word, index|
      #if it already exists
      if Word.exists?(word: word)
         db_word=Word.where(word: word)[0]
        if !db_word.end
            next_word = array[index+1]
            unless db_word.chain.include?(next_word)
              db_word.chain.push(next_word)
            end
           db_word.save
        end

      else
      #if it doesn't exist yet, make a new one
        db_word = Word.new(:word => word)
        #see if it ends the sentence, if so stop there
        if ['.', '?', '!'].include?(word[word.length-1])
          db_word.end=true
        else
          #otherwise, push in the next word unless it's already there
          next_word = array[index+1]
          unless db_word.chain.include?(next_word)
            db_word.chain.push(next_word)
          end

        end
        db_word.save
      end
    end
    #clean up?

  end

  def self.generate_tweet
    current_tweet = ""
    next_tweet=""
    current_word = Word.random
    loop do
      next_tweet+= "#{current_word.word} "

      if next_tweet.length>139
        current_tweet+= ['.', '!'].sample
        break
      end

      current_tweet = next_tweet
      break if current_word.end
      break if current_word.chain=='[]'



      next_word = current_word.chain.sample

      next_db_word = Word.where(word: next_word)[0]
      # break if next_db_word.chain[0]==nil
      current_word= next_db_word
    end
    # CLIENT.update(current_tweet.capitalize)
    # puts CLIENT.user_timeline("realDonaldTrump")
    return current_tweet.capitalize
  end
end

def average_string array
  num_array=[]
  array.each do |str|
    num_array.push(str.length)
  end
  num_array.reduce(:+)/num_array.length
end

#CLIENT.user('realDonaldTrump')
# CLIENT.update("I'm tweeting now check it out yo")
# tweet.full_text
