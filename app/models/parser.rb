require 'treat'
include Treat::Core::DSL

STOP_LIST = ["a", "about", "above", "across", "after", "again", "against", "all", "almost", "alone", "along", "already", "also", "although", "always", "among", "an", "and", "another", "any", "anybody", "anyone", "anything", "anywhere", "are", "area", "areas", "around", "as", "ask", "asked", "asking", "asks", "at", "away", "b", "back", "backed", "backing", "backs", "be", "became", "because", "become", "becomes", "been", "before", "began", "behind", "being", "beings", "best", "better", "between", "big", "both", "but", "by", "c", "came", "can", "cannot", "case", "cases", "certain", "certainly", "clear", "clearly", "come", "could", "d", "did", "differ", "different", "differently", "do", "does", "done", "down", "down", "downed", "downing", "downs", "during", "e", "each", "early", "either", "end", "ended", "ending", "ends", "enough", "even", "evenly", "ever", "every", "everybody", "everyone", "everything", "everywhere", "f", "face", "faces", "fact", "facts", "far", "felt", "few", "find", "finds", "first", "for", "four", "from", "full", "fully", "further", "furthered", "furthering", "furthers", "g", "gave", "general", "generally", "get", "gets", "give", "given", "gives", "go", "going", "good", "goods", "got", "great", "greater", "greatest", "group", "grouped", "grouping", "groups", "h", "had", "has", "have", "having", "he", "her", "here", "herself", "high", "high", "high", "higher", "highest", "him", "himself", "his", "how", "however", "i", "if", "important", "in", "interest", "interested", "interesting", "interests", "into", "is", "it", "its", "itself", "j", "just", "k", "keep", "keeps", "kind", "knew", "know", "known", "knows", "l", "large", "largely", "last", "later", "latest", "least", "less", "let", "lets", "like", "likely", "long", "longer", "longest", "m", "made", "make", "making", "man", "many", "may", "me", "member", "members", "men", "might", "more", "most", "mostly", "mr", "mrs", "much", "must", "my", "myself", "n", "necessary", "need", "needed", "needing", "needs", "never", "new", "new", "newer", "newest", "next", "no", "nobody", "non", "noone", "not", "nothing", "now", "nowhere", "number", "numbers", "o", "of", "off", "often", "old", "older", "oldest", "on", "once", "one", "only", "open", "opened", "opening", "opens", "or", "order", "ordered", "ordering", "orders", "other", "others", "our", "out", "over", "p", "part", "parted", "parting", "parts", "per", "perhaps", "place", "places", "point", "pointed", "pointing", "points", "possible", "present", "presented", "presenting", "presents", "problem", "problems", "put", "puts", "q", "quite", "r", "rather", "really", "right", "right", "room", "rooms", "s", "said", "same", "saw", "say", "says", "second", "seconds", "see", "seem", "seemed", "seeming", "seems", "sees", "several", "shall", "she", "should", "show", "showed", "showing", "shows", "side", "sides", "since", "small", "smaller", "smallest", "so", "some", "somebody", "someone", "something", "somewhere", "state", "states", "still", "still", "such", "sure", "t", "take", "taken", "than", "that", "the", "their", "them", "then", "there", "therefore", "these", "they", "thing", "things", "think", "thinks", "this", "those", "though", "thought", "thoughts", "three", "through", "thus", "to", "today", "together", "too", "took", "toward", "turn", "turned", "turning", "turns", "two", "u", "under", "until", "up", "upon", "us", "use", "used", "uses", "v", "very", "w", "want", "wanted", "wanting", "wants", "was", "way", "ways", "we", "well", "wells", "went", "were", "what", "when", "where", "whether", "which", "while", "who", "whole", "whose", "why", "will", "with", "within", "without", "work", "worked", "working", "works", "would", "x", "y", "year", "years", "yet", "you", "young", "younger", "youngest", "your", "yours", "z"]

# here is the above stop-list came from: http://www.lextek.com/manuals/onix/stopwords1.html

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

lyric_string2 = " You were my sun You were my earth But you didn't know all the ways I loved you, no So you took a chance And made other plans But I bet you didn't think that they would come crashing down, no
 You don't have to say, what you did, I already know, I found out from him Now there's just no chance, for you and me, there'll never be And don't it make you sad about it
 You told me you loved me Why did you leave me, all alone Now you tell me you need me When you call me, on the phone Girl I refuse, you must have me confused With some other guy Your bridges were burned, and now it's your turn To cry, cry me a river Cry me a river-er Cry me a river Cry me a river-er, yea yea
 I know that they say That somethings are better left unsaid It wasn't like you only talked to him and you know it (Don't act like you don't know it) All of these things people told me Keep messing with my head (Messing with my head) You should've picked honesty Then you may not have blown it (Yea..)
 You don't have to say, what you did, (Don't have to say, what you did) I already know, I found out from him (I already know, uh) Now there's just no chance, for you and me, there'll never be (No chance, you and me) And don't it make you sad about it
 You told me you loved me Why did you leave me, all alone (All alone) Now you tell me you need me When you call me, on the phone (When you call me on the phone) Girl I refuse, you must have me confused With some other guy (I'm not like them baby) Your bridges were burned, and now it's your turn (It's your turn) To cry, cry me a river (Go on and just) Cry me a river-er (Go on and just) Cry me a river (Baby go on and just) Cry me a river-er, yea yea
 Oh (Oh) The damage is done So I guess I be leaving Oh (Oh) The damage is done So I guess I be leaving Oh (Oh) The damage is done So I guess I be leaving Oh (Oh) The damage is done So I guess I be... leaving
 You don't have to say, what you did, (Don't have to say, what you did) I already know, I found out from him (I already know, uh) Now there's just no chance, for you and me, there'll never be (No chance, you and me) And don't it make you sad about it
 Cry me a river (Go on and just) Cry me a river-er (Baby go on and just) Cry me a river (You can go on and just) Cry me a river-er, yea yea
 Cry me a river (Baby go on and just) Cry me a river-er (Go on and just) Cry me a river (Cause I've already cried) Cry me a river-er, yea yea (Ain't gonna cry no more, yea-yea)
 Cry me a river Cry me a river, oh Cry me a river, oh Cry me a river, oh
 Cry me a river, oh (Cry me, cry me) Cry me a river, oh (Cry me, cry me) Cry me a river, oh (Cry me, cry me) Cry me a river, oh (Cry me, cry me)
 Cry me a river, oh (Cry me, cry me) Cry me a river, oh (Cry me, cry me) Cry me a river (Cry me, cry me)  "

lyric_string3 = "Talk to me softly
There's something in your eyes
Don't hang your head in sorrow
And please don't cry
I know how you feel inside I've
I've been there before
Somethin's changin' inside you
And don't you know

Don't you cry tonight
I still love you baby
Don't you cry tonight
Don't you cry tonight
There's a heaven above you baby
And don't you cry tonight

Give me a whisper
And give me a sigh
Give me a kiss before you
tell me goodbye
Don't you take it so hard now
And please don't take it so bad
I'll still be thinkin' of you
And the times we had...baby

And don't you cry tonight
Don't you cry tonight
Don't you cry tonight
There's a heaven above you baby
And don't you cry tonight

And please remember that I never lied
And please remember
how I felt inside now honey
You gotta make it your own way
But you'll be alright now sugar
You'll feel better tomorrow
Come the morning light now baby

And don't you cry tonight
An don't you cry tonight
An don't you cry tonight
There's a heaven above you baby
And don't you cry
Don't you ever cry
Don't you cry tonight
Baby maybe someday
Don't you cry
Don't you ever cry
Don't you cry
Tonight"

lyric_string4 = "Standing there alone, the ship is waiting
All systems are go, are you sure?
Control is not convinced
But the computer has the evidence
No need to abort

The countdown starts

Watching in a trance, the crew is certain
Nothing left to chance, all is working
Trying to relax, up in the capsule
'Send me up a drink', jokes Major Tom
The count goes on

4, 3, 2, 1
Earth below us
Drifting falling
Floating weightless
Calling calling home

Second stage is cut, we're now in orbit
Stabilizers up, running perfect
Starting to collect, requested data
What will it effect, when all is done
Thinks Major Tom

Back at ground control, there is a problem
Go to rockets full, not responding
Hello Major Tom, are you receiving
Turn the thrusters on, we're standing by
There's no reply

4, 3, 2, 1
Earth below us
Drifting, falling
Floating, weightless
Calling, calling, home

Across the stratosphere
A final message, 'Give my wife my love'
Then nothing more

Far beneath the ship, the world is mourning
They don't realize, he's alive
No one understands but Major Tom sees
Now the light commands, this is my home
I'm coming home

Earth below us
Drifting falling
Floating weightless
Coming home

Earth below us
Drifting falling
Floating weightless
Coming home

Earth below us
Drifting falling
Floating weightless
Coming coming home

Home
Home
Home
Home
Home
Home
Home
Home"


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

p present_song_themes(lyric_string2)





