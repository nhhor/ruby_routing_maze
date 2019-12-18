require("rspec")
require("room")

describe '#Room' do

  before(:each) do
    Room.clear()
    Song.clear()
  end

  describe('#==') do
    it("is the same room if it has the same attributes as another room") do
      room = Room.new("Blue", nil, nil, nil, nil)
      room2 = Room.new("Blue", nil, nil, nil, nil)
      expect(room).to(eq(room2))
    end
  end

  describe(".all") do
    it("returns an empty array when there are no rooms") do
      expect(Room.all()).to(eq([]))
    end
  end
  describe('#save') do
    it("saves an room") do
      room = Room.new("Giant Steps", nil, nil, nil, nil) # nil added as second argument
      room.save()
      room2 = Room.new("Blue", nil, nil, nil, nil) # nil added as second argument
      room2.save()
      expect(Room.all).to(eq([room, room2]))
    end
  end

  describe('.clear') do
    it("clears all rooms") do
      room = Room.new("Giant Steps", nil, nil, nil, nil)
      room.save()
      room2 = Room.new("Blue", nil, nil, nil, nil)
      room2.save()
      Room.clear()
      expect(Room.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an room by id") do
      room = Room.new("Giant Steps", nil, nil, nil, nil)
      room.save()
      room2 = Room.new("Blue", nil, nil, nil, nil)
      room2.save()
      expect(Room.find(room.id)).to(eq(room))
    end
  end

  describe('#update') do
    it("updates an room by id") do
      room = Room.new("Giant Steps", nil, nil, nil, nil)
      room.save()
      room.update("A Love Supreme", nil, nil, nil)
      expect(room.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an room by id") do
      room = Room.new("Giant Steps", nil, nil, nil, nil)
      room.save()
      room2 = Room.new("Blue", nil, nil, nil, nil)
      room2.save()
      room.delete()
      expect(Room.all).to(eq([room2]))
    end
  end

  describe('.search') do
    it("Searches for matching rooms by name") do
      room1 = Room.new("Giant Steps", nil, nil, nil, nil)
      room1.save()
      room2 = Room.new("Blue", nil, nil, nil, nil)
      room2.save()
      room3 = Room.new("Green Steps", nil, nil, nil, nil)
      room3.save()

      expect(Room.search("Steps")).to(eq([room1,room3]))
    end
  end

  describe('.sort') do
    it('sorts by alphebetical order') do
    room1 = Room.new("Giant Steps", nil, nil, nil, nil)
    room1.save()
    room2 = Room.new("Blue", nil, nil, nil, nil)
    room2.save()
    room3 = Room.new("Green Steps", nil, nil, nil, nil)
    room3.save()
    expect(Room.sort()).to(eq([room2, room1, room3]))
  end
end

describe('#songs') do
    it("returns an room's songs") do
      room = Room.new("Giant Steps", nil, nil, nil, nil)
      room.save()
      song = Song.new("Naima", room.id, nil)
      song.save()
      song2 = Song.new("Cousin Mary", room.id, nil)
      song2.save()
      expect(room.songs).to(eq([song, song2]))
    end
  end

# describe('#sold') do
#   it('sorts by alphebetical order') do
#   room1 = Room.new("Giant Steps", nil, nil, nil, nil)
#   room1.save()
#   room2 = Room.new("Blue", nil, nil, nil, nil)
#   room2.save()
#   room3 = Room.new("Green Steps", nil, nil, nil, nil)
#   room3.save()
#   room2.sold()
#
#   expect(@@sold_rooms).to(eq([room2]))
# end
# end


end

# end
