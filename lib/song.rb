class Song
  attr_reader :id
  attr_accessor :name, :room_id

  @@songs = {}
  @@total_rows = 0

  def initialize(name, room_id, id)
    @name = name
    @room_id = room_id
    @id = id || @@total_rows += 1
  end

  def ==(song_to_compare)
    (self.name() == song_to_compare.name()) && (self.room_id() == song_to_compare.room_id())
  end

  def self.all
    @@songs.values
  end

  def save
    @@songs[self.id] = Song.new(self.name, self.room_id, self.id)
  end

  def self.find(id)
    @@songs[id]
  end

  def update(name, room_id)
    self.name = name
    self.room_id = room_id
    @@songs[self.id] = Song.new(self.name, self.room_id, self.id)
  end

  def delete
    @@songs.delete(self.id)
  end

  def self.clear
    @@songs = {}
  end

  def self.find_by_room(alb_id)
    songs = []
    @@songs.values.each do |song|
      if song.room_id == alb_id
        songs.push(song)
      end
    end
    songs
  end

  def room
    Room.find(self.room_id)
  end
end
