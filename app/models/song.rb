require 'open-uri'
require 'nokogiri'
require 'treat'
include Treat::Core::DSL

require 'treat'
include Treat::Core::DSL

STOP_LIST = ["a", "about", "above", "across", "after", "again", "against", "all", "almost", "alone", "along", "already", "also", "although", "always", "among", "an", "and", "another", "any", "anybody", "anyone", "anything", "anywhere", "are", "area", "areas", "around", "as", "ask", "asked", "asking", "asks", "at", "away", "b", "back", "backed", "backing", "backs", "be", "became", "because", "become", "becomes", "been", "before", "began", "behind", "being", "beings", "best", "better", "between", "big", "both", "but", "by", "c", "came", "can", "cannot", "case", "cases", "certain", "certainly", "clear", "clearly", "come", "could", "d", "did", "differ", "different", "differently", "do", "does", "done", "down", "down", "downed", "downing", "downs", "during", "e", "each", "early", "either", "end", "ended", "ending", "ends", "enough", "even", "evenly", "ever", "every", "everybody", "everyone", "everything", "everywhere", "f", "face", "faces", "fact", "facts", "far", "felt", "few", "find", "finds", "first", "for", "four", "from", "full", "fully", "further", "furthered", "furthering", "furthers", "g", "gave", "general", "generally", "get", "gets", "give", "given", "gives", "go", "going", "good", "goods", "got", "great", "greater", "greatest", "group", "grouped", "grouping", "groups", "h", "had", "has", "have", "having", "he", "her", "here", "herself", "high", "high", "high", "higher", "highest", "him", "himself", "his", "how", "however", "i", "if", "important", "in", "interest", "interested", "interesting", "interests", "into", "is", "it", "its", "itself", "j", "just", "k", "keep", "keeps", "kind", "knew", "know", "known", "knows", "l", "large", "largely", "last", "later", "latest", "least", "less", "let", "lets", "like", "likely", "long", "longer", "longest", "m", "made", "make", "making", "man", "many", "may", "me", "member", "members", "men", "might", "more", "most", "mostly", "mr", "mrs", "much", "must", "my", "myself", "n", "necessary", "need", "needed", "needing", "needs", "never", "new", "new", "newer", "newest", "next", "no", "nobody", "non", "noone", "not", "nothing", "now", "nowhere", "number", "numbers", "o", "of", "off", "often", "old", "older", "oldest", "on", "once", "one", "only", "open", "opened", "opening", "opens", "or", "order", "ordered", "ordering", "orders", "other", "others", "our", "out", "over", "p", "part", "parted", "parting", "parts", "per", "perhaps", "place", "places", "point", "pointed", "pointing", "points", "possible", "present", "presented", "presenting", "presents", "problem", "problems", "put", "puts", "q", "quite", "r", "rather", "really", "right", "right", "room", "rooms", "s", "said", "same", "saw", "say", "says", "second", "seconds", "see", "seem", "seemed", "seeming", "seems", "sees", "several", "shall", "she", "should", "show", "showed", "showing", "shows", "side", "sides", "since", "small", "smaller", "smallest", "so", "some", "somebody", "someone", "something", "somewhere", "state", "states", "still", "still", "such", "sure", "t", "take", "taken", "than", "that", "the", "their", "them", "then", "there", "therefore", "these", "they", "thing", "things", "think", "thinks", "this", "those", "though", "thought", "thoughts", "three", "through", "thus", "to", "today", "together", "too", "took", "toward", "turn", "turned", "turning", "turns", "two", "u", "under", "until", "up", "upon", "us", "use", "used", "uses", "v", "very", "w", "want", "wanted", "wanting", "wants", "was", "way", "ways", "we", "well", "wells", "went", "were", "what", "when", "where", "whether", "which", "while", "who", "whole", "whose", "why", "will", "with", "within", "without", "work", "worked", "working", "works", "would", "x", "y", "year", "years", "yet", "you", "young", "younger", "youngest", "your", "yours", "z", "oh", "yeah"]

# here is the above stop-list came from: http://www.lextek.com/manuals/onix/stopwords1.html

artist = 'stone+temple+pilots'
song = 'plush'

url = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=" + artist + "&song=" + song

search_response = open(url)
ndoc_search = Nokogiri.parse(search_response)
lyric_check_sum = ndoc_search.xpath("//lyricchecksum").first.content
lyric_id = ndoc_search.xpath("//lyricid").first.content

new_url = "http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId=" + lyric_id +"&lyricCheckSum="+lyric_check_sum

sleep(1)

get_lyrics = open(new_url)
ndoc_lyrics = Nokogiri.parse(get_lyrics)

words = ndoc_lyrics.xpath("//lyric").first.content


#**************** vvvvvvANALYZER  ^^^^^^^^ FETCHER

def remove_asterisks(string)
  string.gsub!(/\*/, '')
end

def remove_notice(string)
  string.gsub!(/This Lyrics is NOT for Commercial use/, ' ')
end

def remove_endline(string)
  string.gsub!(/\n/, ' ')
end

def remove_non_word_characters(string)
  string.gsub!(/[\d\W]/, ' ')
end

def string_to_array(string)
  string.split(" ")
end

def scrub_string_into_array(string)
  remove_asterisks(string)
  remove_notice(string)
  remove_endline(string)
  remove_non_word_characters(string)
  string.downcase!
  array_of_words = string_to_array(string)
end


def stemmify_words_in_array(array)
  array_of_stemmed_words = []
  array.each do |word|
    array_of_stemmed_words << word.stem
  end
  array_of_stemmed_words
end

def remove_the_stop_words(array)
  array_without_stop_words = []
  array.each do |word|
    array_without_stop_words << word unless STOP_LIST.include?(word)
  end
  array_without_stop_words
end

def count_words(array)
  word_count = {}
  array.each do |word|
     if word_count.key?(word)
      word_count[word] += 1
     else
      word_count[word] = 1
    end
  end
  word_count
end

def sort_counted_words(hash_of_word_counts)
  Hash[hash_of_word_counts.sort_by{|k, v| v}.reverse]
end

def return_themes(sorted_word_count)
  themes = sorted_word_count.keys
  [themes[0], themes[1], themes[2], themes[3]]
end


def present_song_themes(song)
  clean_array = scrub_string_into_array(song)
  array_of_stemmed_words = stemmify_words_in_array(clean_array)
  array_without_stop_words = remove_the_stop_words(array_of_stemmed_words)
  word_count = count_words(array_without_stop_words)
  sorted_word_count = sort_counted_words(word_count)
  return_themes(sorted_word_count)
end


p present_song_themes(words)

