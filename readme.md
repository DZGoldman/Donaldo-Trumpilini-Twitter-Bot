## Donaldo Trumpilini

![](trump.png?raw=true)

Donaldo Trumpilni is a twitter bot that generates tweets in the mashed-up literary style of Donald Trump and Benito Mousolini.

#### Q: How are the tweets generated?
The tweets are generated via a Markov Chain algorithm implemented in Ruby. The text data is stored in a postgreSQL database with each individual word as a record.

#### Q: Where does the data come from?
Trump's text data comes from his twitter feed; Mousolini's from his autobiography.

#### Q: Is the data-set fixed?
No. As Trump's tweets come in, they are algorithmically converted into Markov-Chain ready format and stored in the database. For each tweet that is added into the database, a single sentence from Mousolini's autobiography is also added, to maintain that much sought-after Trump/Mousolini balance.

#### Q: What else does he do?
Trumpilini will occasionally tweet @ one of the people he follows. He'll also follow back anybody who follows him. He may even retweet you if he's in the mood.

#### What technologies are used?
- Ruby on Rails
- postgreSQL
- Twitter API
- Figaro
- Heroku scheduler
