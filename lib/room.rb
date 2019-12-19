class Room
  attr_reader :id, :name, :room_color, :room_prop, :room_sense, :room_exit ##CHANGE#Our new save method will need reader methods.
  # attr_accessor :name

  @@rooms = {}
  @@score = 1

  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, id, room_color, room_prop, room_sense, room_exit) ##CHANGE # We've added id as a second parameter.
    @name = name
    @id = id || @@total_rows += 1  # We've added code to handle the id.
    @room_color = room_color
    @room_prop = room_prop
    @room_sense = room_sense
    @room_exit = room_exit
  end

  def admin_start
    red_room = Room.new("red", nil,"words", "words", "words", 'right')
    red_room.save()
    green_room = Room.new("green", nil,"words", "words", "words", 'straight')
    green_room.save()
    blue_room = Room.new("blue", nil,"words", "words", "words", 'left')
    blue_room.save()
  end


  def correct
    puts "correct start..."
    "/rooms/#{}"
    link_to('test', http)
    @@rooms.values[@@score]
    puts "correct end..."

  end

  def self.all
    @@rooms.values()
  end

  def self.search(x)
    @@rooms.values().select {|e| /#{x}/i.match? e.name}
  end

  def save
    @@rooms[self.name] = Room.new(self.name, self.id, self.room_color, self.room_prop, self.room_sense, self.room_exit) #CHANGE
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

  def update(name2, room_color, room_prop, room_sense, room_exit)
    room = Room.new(name2, nil, room_color, room_prop, room_sense, room_exit) # nil added as second argument
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
