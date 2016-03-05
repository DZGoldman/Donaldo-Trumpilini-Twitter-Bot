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
      puts word
      if Word.exists?(word: word)
         db_word=Word.where(word: word)[0]
         db_word.chain.push(array[index+1])
         db_word.save
      else
        db_word = Word.new(:word => word)
        db_word.chain.push(array[index+1])
        db_word.save
      end
    end
    #clean up?
    #if word isn't in database make new Word, start the array with next word
    # if it is, push next word into array
    # check for repeats of word?
  end

  def generate_tweet

  end
end



#CLIENT.user('realDonaldTrump')
#ClIENT.update("I'm tweeting with @gem!")
# tweet.full_text

@speech ="Recent articles Recent came out talking about how great a company we built, and now we want to put that same ability into doing something for our nation. I mean, our nation is in serious trouble. We’re being chilled on trade, absolutely destroyed. China is just taking advantage of us. I have nothing against China. I have great respect for China, but their leaders are too smart for our leaders. Our leaders don’t have a clue and the trade deficits at $400 billion and $500 are too much. No country can sustain that kind of trade deficit. It won’t be that way for long. We have the greatest business leaders in the world on my team already and, believe me, we’re going to redo those trade deals and it’s going to be a thing of beauty."
puts @speech
