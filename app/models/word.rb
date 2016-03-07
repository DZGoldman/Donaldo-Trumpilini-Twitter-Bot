class Word < ActiveRecord::Base
  validates :word, presence: true
end
