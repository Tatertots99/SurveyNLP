require(quanteda)
library(tidyr)
library(dplyr)

#read in and clean data
#raw_dat <- read_csv("Mar2020_Anonymized_UN Decade of Ocean Science for Sustainable Development Early Career Oc.csv")

colnames(raw_dat)

survey_test_dat <- read.csv("survey_test_dat.csv")
head(survey_test_dat)
dat2a <- data.frame(stack(survey_test_dat[1:3]))
dim(dat2a)
head(dat2a)
string1 <- dat2a[,1]
corpus1 <- corpus(string1)

tokens1 <- tokens(corpus1, what = "word", remove_punct = TRUE, 
                    remove_numbers = TRUE)

#clean tokens
tokens1<- tokens_select(tokens1, selection = "remove", stopwords('en'))
tokens1 <- tokens_wordstem(tokens1)
#tokens1 <- tokens_tolower(tokens1)
#tokens1<- tokens_select(tokens1, min_nchar = 3)

#create the doc-feature matrix for 1 word
dfm1<- dfm(tokens1, remove = stopwords())

context <- kwic(tokens1, "plastic", window = 6)
View(as.data.frame(context))

topfeatures(dfm1, 100)
freq_words <- textstat_frequency(dfm1)
freq_words

#creaete dfm for 2 words
tok2 <- tokens_ngrams(tokens1, n=2)
dfm2<- dfm(tok2, remove = stopwords())
topfeatures(dfm2, 30)

#creaete dfm for 3 words
tokens1<- tokens_select(tokens1, selection = "remove", stopwords('en'))
tok3 <- tokens_ngrams(tokens1, n=3)
dfm3<- dfm(tok3, remove = stopwords())
topfeatures(dfm3, 30)


