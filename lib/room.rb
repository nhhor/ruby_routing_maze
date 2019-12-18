class Room
  attr_reader :id, :name, :year, :genre, :artist ##CHANGE#Our new save method will need reader methods.
  # attr_accessor :name

  @@rooms = {}

  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, id, year, genre, artist) ##CHANGE # We've added id as a second parameter.
    @name = name
    @id = id || @@total_rows += 1  # We've added code to handle the id.
    @year = year
    @genre = genre
    @artist = artist
  end

  def self.all
    @@rooms.values()
  end

  def self.search(x)
    @@rooms.values().select {|e| /#{x}/i.match? e.name}
  end

  def save
    @@rooms[self.name] = Room.new(self.name, self.id, self.year, self.genre, self.artist) #CHANGE
  end

  def ==(room_to_compare)

    self.name() == room_to_compare.name()

  end

  def self.clear
    @@rooms = {}
    @@total_rows = 0
  end

  def self.find(name)
    @@rooms[name]
  end

  def update(name2, year, genre, artist)
    room = Room.new(name2, nil, year, genre, artist) # nil added as second argument
    room.save()
    @@rooms.delete(self.name)
  end

  def delete
    @@rooms.delete(self.name)
  end

  def self.sort()
    @@rooms.values().sort { |a, b| a.name <=> b.name }
    # @@rooms.values()
  end

  def songs
    Song.find_by_room(self.id)
  end

end
