class Bot < ActiveRecord::Base
  def self.markov_tweets (tweets)
    tweets.each do |tweet|
      make_markov(tweet.full_text)
    end
  end

  def self.make_markov text
    clean_text = text.tr('"', '')
    array = clean_text.split(' ')
    #iterate through each word
    array.each_with_index do |word, index|
      is_last_word=false
      #see if it ends the sentence, or ends the inputed sentence, stop there
      if ['.', '?', '!'].include?(word[word.length-1]) || index==array.length-1
        if !Word.exists?(word: word, end: true)
          Word.create(:word => word, :end => true)
        end
        next
      end

      #if it already exists
      if Word.exists?(word: word)
         db_word=Word.where(word: word)[0]
         next_word = array[index+1]
         unless db_word.chain.include?(next_word)
           db_word.chain.push(next_word)
         end
        db_word.save
        #if it doesn't exist yet, make a new one
      else
        db_word = Word.new(:word => word)
          # push in the next word unless it's already there
        next_word = array[index+1]
        unless db_word.chain.include?(next_word)
          db_word.chain.push(next_word)
        end
        db_word.save
      end
    end
    #clean up?

  end

  def self.generate_tweet
    current_tweet = ""
    next_tweet=""
    current_db_word = Word.where(end: false).random
    first = true
    recur = false
    loop do
      #remove space in front in it's the first iteration
      first ? next_tweet+= "#{current_db_word.word}" : next_tweet+=" #{current_db_word.word}"
      first = false
      break if next_tweet.length>138

      current_tweet = next_tweet
      break if current_db_word.end
      # break if current_db_word.chain=='[]'
      next_word = current_db_word.chain.sample
      # if Word.where(word: next_word)[0]==nil
      #   recur=true
      #   Bot.generate_tweet
      #   break
      # end
      next_db_word =Word.where(word: next_word)[0]
      # break if next_db_word.chain[0]==nil
      current_db_word= next_db_word
    end
    if !['!','.','?'].include?(current_tweet.last)
      current_tweet+= ['!', '.'].sample
    end
    CLIENT.update( current_tweet.slice(0,1).capitalize + current_tweet.slice(1..-1))
  end

  def self.generate_reply
    current_tweet = ""
    next_tweet=""
    current_db_word = Word.where(end: false).random
    first = true
    recur = false
    loop do
      #remove space in front in it's the first iteration
      first ? next_tweet+= "#{current_db_word.word}" : next_tweet+=" #{current_db_word.word}"
      first = false
      break if next_tweet.length>100

      current_tweet = next_tweet
      break if current_db_word.end
      # break if current_db_word.chain=='[]'
      next_word = current_db_word.chain.sample
      # if Word.where(word: next_word)[0]==nil
      #   recur=true
      #   Bot.generate_tweet
      #   break
      # end
      next_db_word =Word.where(word: next_word)[0]
      # break if next_db_word.chain[0]==nil
      current_db_word= next_db_word
    end
    if !['!','.','?'].include?(current_tweet.last)
      current_tweet+= ['!', '.'].sample
    end
    return current_tweet.slice(0,1).capitalize + current_tweet.slice(1..-1)

  end

  def self.start_stream
    # TODO capitalizing for @mentions
    STREAMER.user do |object|
      # puts object
      case object

      when Twitter::Streaming::Event
      unless object.source.id==CLIENT.user.id
        #follow on favorites or follows
        if object.name==(:favorite ||:follow)
          puts "favorited or followed"
          CLIENT.follow(object.source)
        end
      end

      when Twitter::Tweet
        unless object.user.screen_name=="Don_Trumpilini"
          puts "some tweet: "+ object.full_text

          if object.user.screen_name=="realDonaldTrump"
            puts 'trump tweeted that!'
            Bot.generate_tweet
            Bot.make_markov (object.full_text)
            markov_some_sentences 1

            #follow anybody he mentions

            #follow-back on retweets
          elsif object.full_text.include? "RT @Don_Trumpilini:"
            puts "Bot was retweeted"
            CLIENT.follow(object.user)
            #  retweet @ mentions
          elsif object.full_text.include? "@Don_Trumpilini"
            puts "bot was mentnioed"
            CLIENT.retweet(object)
            CLIENT.follow(object.user)
            # reply to anyone who tweets about him
          elsif object.full_text.downcase.include? "trump"
            puts("follower mentioned trump")
            puts ("@#{object.user.screen_name} #{Bot.generate_reply}")
            puts object.id
            CLIENT.update("@#{object.user.screen_name} #{Bot.generate_reply}", in_reply_to_status_id: object.id)
          end
        end
      when Twitter::Entity::UserMention
        puts 'menioned!'
        # (doesn't work)
      when Twitter::DirectMessage
        puts "It's a direct message!"

      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
      end
    end
  end

end


#CLIENT.user('realDonaldTrump')
# CLIENT.update("I'm tweeting now check it out yo")
# tweet.full_text
# puts CLIENT.user_timeline("realDonaldTrump")
