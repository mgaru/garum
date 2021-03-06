#Import the text from all 56 Donald Trump speeches into R and tokenize the data into a tidy text data frame,
#using words as tokens. After removing stop words and the word "applause", plot the top 15 most common
#words used in Trump's speeches.


library(readr)
library(tidytext)
full_speech <- read_lines("C:/Users/Mayur/Desktop/neu/Spring 18/Intro to Data processing/Homework 3/trump_speeches-master/data/full_speech.txt")
full_speech
library(tokenizers)
head(full_speech, n=10)

full_speech_t <- tibble(line=1:length(full_speech), text=full_speech)
full_speech_t
##Un nesting the document into the tokens equal to word.

full_speech_unnest <- full_speech_t %>% unnest_tokens(word, text)
full_speech_unnest
#counting the most frequent words

full_speech_unnest %>% count(word, sort=TRUE)

##viewing stop words Removing stop words & word "applause"

applause <- data.frame (word= "applause",lexicon = "SMART")
stop_words_update <- rbind(stop_words, token)
View(stop_words_update)
full_speech_new <- tidy_full_speech %>%
  anti_join(stop_words_update, by="word") %>%
  count(word, sort=TRUE) 

##Here we get the list of most frequent words after removing stopwords & word "applause"
full_speech_new 





#Now, Re-tokenize the text of all 56 Donald Trump Speeches into a new tidy text data frame, using bigrams as
#tokens. Remove each bigram where either word is a stop word or the word "applause". Then plot the top 15
#most common bigrams in Trump's speeches

full_speech_bigrams <- full_speech_unnest  %>% unnest_tokens(bigram, word, token = "ngrams", n = 2)

##Here we get tibble with bigrams

full_speech_bigrams


#seperating words to filter stop words 
full_speech_bigrams_seperate <- separate(full_speech_bigrams, bigram , into = c("word1", "word2"))
full_speech_bigrams_seperate

#removing stop words from bigrams

full_speech_bigrams_new <- full_speech_bigrams_seperate %>%
  filter(!word1 %in% stop_words_update$word) %>%
  filter(!word2 %in% stop_words_update$word) %>% count(word1, word2, sort=TRUE)
full_speech_bigrams_new 





#We would like to do a sentiment analysis of Donald Trump's speeches. In order to make sure sentiments are
#assigned to appropriate contexts, first tokenize the speeches into bigrams, and then filter out all bigrams
#where the first word is any of "not", "no", or "never".
#Now consider only the second word of each bigram. After filtering out the words "applause" and "trump",
#create a plot of the 10 most common words in Trump's speeches that are associated with each of the 10
#sentiments in the "nrc" lexicon

library(tidyverse)

#Using a dataset without filtering through stop words as it already contains "no","not","never" 
trump_senti_data <- full_speech_bigrams_seperate
trump_senti_data

n <- c('1','2','3')

nw <- c('no','not','never')
negative_words <- data.frame(n,nw)

n1 <- c('1','2')
ow<- c('trump','applause') 

otherstop <- data.frame(n1,ow)
stop <- data.frame(n,word)

trump_senti_data_new  <- trump_senti_data %>% filter(!word1 %in% negative_words$nw) %>%
  filter(!word2 %in% otherstop$ow) %>% count(word1, word2, sort=TRUE)

trump_senti_data_new 

##Also rempoving stop words 


trump_tidy <- trump_senti_data_new %>% filter(!word1 %in% negative_words$nw) %>%
  filter(!word2 %in% otherstop$ow) %>% count(word1, word2, sort=TRUE)


get_sentiments("nrc")

library(stringr) 