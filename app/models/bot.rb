class Bot < ActiveRecord::Base
  def self.search_words words
    CLIENT.search(words, lang: "en").first.text
  end

  def self.trump_tweets
    CLIENT.user_timeline("realDonaldTrump")
  end

  def self.make_markov text
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

      if next_tweet.length>149
        current_tweet+= ['.', '!'].sample
        break
      end

      current_tweet = next_tweet
      break if current_word.end


      next_word = current_word.chain.sample
      next_db_word = Word.where(word: next_word)[0]
      current_word= next_db_word
    end
    ClIENT.update(current_tweet.capitalize)
    # puts CLIENT.user_timeline("realDonaldTrump")
    return current_tweet.capitalize
  end
end



#CLIENT.user('realDonaldTrump')
ClIENT.update("I'm tweeting with @gem!")
# tweet.full_text

@trump_speech ="Recent articles Recent came out talking about how great a company we built, and now we want to put that same ability into doing something for our nation. I mean, our nation is in serious trouble. We’re being chilled on trade, absolutely destroyed. China is just taking advantage of us. I have nothing against China. I have great respect for China, but their leaders are too smart for our leaders. Our leaders don’t have a clue and the trade deficits at $400 billion and $500 are too much. No country can sustain that kind of trade deficit. It won’t be that way for long. We have the greatest business leaders in the world on my team already and, believe me, we’re going to redo those trade deals and it’s going to be a thing of beauty."

@mous_speech= "It is not only an army marching towards its goal, but it is forty-four million Italians marching in unity behind this army. Because the blackest of injustices is being attempted against them, that of taking from them their place in the sun. When in 1915 Italy threw in her fate with that of the Allies, how many cries of admiration, how many promises were heard? But after the common victory, which cost Italy six hundred thousand dead, four hundred thousand lost, one million wounded, when peace was being discussed around the table only the crumbs of a rich colonial booty were left for us to pick up. For thirteen years we have been patient while the circle tightened around us at the hands of those who wish to suffocate us."
