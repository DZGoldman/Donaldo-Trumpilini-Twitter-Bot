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
