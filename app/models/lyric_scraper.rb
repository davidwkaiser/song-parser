require 'nokogiri'
require 'open-uri'
require 'net/http'

google_url = "https://www.google.com/?gws_rd=ssl#q=lyrics"

song = "lumineers ophelia"
song_words = song.split(' ')

song_words.each do |word|
  google_url += "+" + word
end

puts google_url
html = open(google_url)
ndoc = Nokogiri.parse(html)
# puts ndoc
# puts "*****"
puts ndoc.css('')

# url = "https://play.google.com/music/preview/Tnlwgpr4rl62zblmhhowiep653a?lyrics=1&utm_source=google&utm_medium=search&utm_campaign=lyrics&pcampaignid=kp-lyrics"


# html = open(url)
# nokogiri_document = Nokogiri.parse(html)

# lyrics = nokogiri_document.css('.lyrics > p').to_s
lyrics = ndoc.css('.lyrics > p').to_s

#this worked for don't cry, not born to run
#maybe look for div class two above <br> element


def scrub_tags(text)
 text.gsub!(/<.{1,3}>/,' ')
end

puts scrub_tags(lyrics)
# puts lyrics

#use nokogiri to search google
#then find the a tag around "full lyrics on google play"
#then go there and scrape the lyrics!




