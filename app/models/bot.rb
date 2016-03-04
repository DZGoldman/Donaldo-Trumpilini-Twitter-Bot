class Bot < ActiveRecord::Base
  def self.search_words words
    CLIENT.search(words, lang: "en").first.text
  end

  def self.trump_tweets
    CLIENT.user_timeline("realDonaldTrump")
  end
end


#CLIENT.user('realDonaldTrump')
#ClIENT.update("I'm tweeting with @gem!")
# tweet.full_text

# Recent articles came out talking about how great a company we built, and now we want to put that same ability into doing something for our nation. I mean, our nation is in serious trouble. We’re being chilled on trade, absolutely destroyed. China is just taking advantage of us. I have nothing against China. I have great respect for China, but their leaders are too smart for our leaders. Our leaders don’t have a clue and the trade deficits at $400 billion and $500 are too much. No country can sustain that kind of trade deficit. It won’t be that way for long. We have the greatest business leaders in the world on my team already and, believe me, we’re going to redo those trade deals and it’s going to be a thing of beauty.
