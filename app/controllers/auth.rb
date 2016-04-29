get '/' do
  erb :welcome
end

get '/login' do

end

get '/signup' do

end


post '/search' do
  p params
  url = Song.get_url(params)
  words = Song.get_words(url)
  @themes = Song.get_themes(words)
  erb :themes
end
