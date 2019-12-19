require('sinatra')
require('sinatra/reloader')
require('./lib/room')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/admin') do
  test = Room.admin_start()
  @rooms = Room.all
  erb(:admin)
end

get('/') do

  @rooms = Room.all
  erb(:rooms)
end

get ('/rooms') do
  if params["search"]
    @rooms = Room.search(params[:search])
  elsif params["sort"]
    @rooms = Room.sort()
  else
    @rooms = Room.all
  end
  erb(:rooms)
end

get('/rooms/new') do
  erb(:new_room)
end

get('/rooms/:name') do
  @room = Room.find(params[:name])

# WORK IN PROGRESS

  if params.length == 1
    puts "cool..."
  elsif params.keys[0] == @room.room_exit
    # room.next method...
    # @room = self.name
    @room.correct
    # binding.pry
  elsif params.keys[0] != @room.room_exit
    binding.pry
  else
    puts "cool..."
  end

  erb(:room)
end

post('/rooms') do
  room_name = params[:room_name] #room_name?
  room = Room.new(room_name, nil, nil, nil, nil, nil)
  room.save()
  @rooms = Room.all() # Adding this line will fix the error.
  erb(:rooms)
end

get('/rooms/:name/edit') do
  @room = Room.find(params[:name])
  erb(:edit_room)
end

patch('/rooms/:name') do
  @room = Room.find(params[:name])
  values = *params.values
  @room.update(values[1], values[2], values[3], values[4], values[5])
  @rooms = Room.all
  erb(:rooms)
  # binding.pry
end

delete('/rooms/:name') do
  @room = Room.find(params[:name])
  @room.delete()
  @rooms = Room.all
  erb(:rooms)
end

get('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end


# SONGS SONGS SONGS SONGS SONGS SONGS SONGS SONGS SONGS SONGS SONGS SONGS


# Get the detail for a specific song such as lyrics and songwriters.
get('/rooms/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the room the song belongs to.
post('/rooms/:id/songs') do
  @room = Room.find(params[:id].to_i())
  song = Song.new(params[:song_name], @room.id, nil)
  song.save()
  erb(:room)
end

# Edit a song and then route back to the room view.
patch('/rooms/:id/songs/:song_id') do
  @room = Room.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @room.id)
  erb(:room)
end

# Delete a song and then route back to the room view.
delete('/rooms/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @room = Room.find(params[:id].to_i())
  erb(:room)
end
