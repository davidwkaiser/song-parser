require 'open-uri'
require 'nokogiri'

artist = 'seal'
song = 'kiss+from+a+rose'

url = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=" + artist + "&song=" + song

search_response = open(url)
ndoc_search = Nokogiri.parse(search_response)
# puts ndoc_search
  # http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=string&song=string
lyric_check_sum = ndoc_search.xpath("//lyricchecksum").first.content
lyric_id = ndoc_search.xpath("//lyricid").first.content

puts lyric_check_sum
puts lyric_id

new_url = "http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId=" + lyric_id +"&lyricCheckSum="+lyric_check_sum
# puts new_url

sleep(2)

get_lyrics = open(new_url)

# puts get_lyrics
ndoc_lyrics = Nokogiri.parse(get_lyrics)
# puts ndoc_lyrics
words = ndoc_lyrics.xpath("//lyric").first.content
puts words


