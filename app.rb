require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('./lib/artist')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'record_store'})


#  ----Album route----

get('/') do
  # binding.pry
  redirect to('/albums')
  # @albums = Album.all
  # erb(:albums)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  album = Album.new({:name => name, :id => nil})
  album.save()
  redirect to('/albums')
  # @albums = Album.all()
  # erb(:albums)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update({:name => params[:name], :artist_name => params[:artist_name]})
  redirect to('/albums')
  # @albums = Album.all
  # erb(:albums)
end

delete('albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
  # @albums = Album.all
  # erb(:albums)
end


#  ----Song route----

# get the detail for a specific song (ex: lyrics & songwriters)
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# post a new song. After the song is added, sinatra will route to the view for the album the song belongs to
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id =>  @album.id, :id => nil})
  song.save()
  erb(:album)
end

# edit a song & then route back to the album view
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end


# delete a song & then route back to the album view
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete()
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


#  ----Search route----

# display search results page
get('/results') do
  erb(:search_results)
end

# display results
post('/results') do
  erb(:search_results)
end

#  ----Artist route----

# get a list of all artist
get('/artists') do
  @artists = Artist.all
  erb(:albums) # changed from artists
end

# add a new artist
get('/artists/new') do
  erb(:new_artist)
end

# look at the detail page for a single album
get('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  erb(:artist)
end

# add a new album to the list of artists
post('/artists') do
  name = params[:artist_name]
  artist = Artist.new({:name => name, :id => nil})
  artist.save()
  redirect to('/artists')
end

# update a signal album
patch('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update(:name => params[:name], :album_name => params[:album_name])
  redirect to('/artists')
end

# delete an album from list
delete('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  redirect to('/artists')
end

# WIP: add artist to homepage / currently breaking
# check artists.erb (copied over artist code to albums.erb)