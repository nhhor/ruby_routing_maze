require 'rspec'
require 'song'
require 'room'
require 'pry'

describe '#Song' do

  before(:each) do
    Room.clear()
    Song.clear()
    @room = Room.new("Giant Steps", nil, nil, nil, nil)
    @room.save()
  end

  describe('#==') do
    it("is the same song if it has the same attributes as another song") do
      song = Song.new("Naima", @room.id, nil)
      song2 = Song.new("Naima", @room.id, nil)
      expect(song).to(eq(song2))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      song = Song.new("Giant Steps", @room.id, nil)
      song.save()
      song2 = Song.new("Naima", @room.id, nil)
      song2.save()
      expect(Song.all).to(eq([song, song2]))
    end
  end

  describe('.clear') do
    it("clears all songs") do
      song = Song.new("Giant Steps", @room.id, nil)
      song.save()
      song2 = Song.new("Naima", @room.id, nil)
      song2.save()
      Song.clear()
      expect(Song.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a song") do
      song = Song.new("Naima", @room.id, nil)
      song.save()
      expect(Song.all).to(eq([song]))
    end
  end

  describe('.find') do
    it("finds a song by id") do
      song = Song.new("Giant Steps", @room.id, nil)
      song.save()
      song2 = Song.new("Naima", @room.id, nil)
      song2.save()
      expect(Song.find(song.id)).to(eq(song))
    end
  end

  describe('#update') do
    it("updates an song by id") do
      song = Song.new("Naima", @room.id, nil)
      song.save()
      song.update("Mr. P.C.", @room.id)
      expect(song.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an song by id") do
      song = Song.new("Giant Steps", @room.id, nil)
      song.save()
      song2 = Song.new("Naima", @room.id, nil)
      song2.save()
      song.delete()
      expect(Song.all).to(eq([song2]))
    end
  end

  describe('.find_by_room') do
    it("finds songs for an room") do
      room2 = Room.new("Blue", nil, nil, nil, nil)
      room2.save
      song = Song.new("Naima", @room.id, nil)
      song.save()
      song2 = Song.new("California", room2.id , nil)
      song2.save()
      expect(Song.find_by_room(room2.id)).to(eq([song2]))
    end
  end

  describe('#room') do
    it('finds the room a song belongs to') do
      song = Song.new('Naima', @room.id, nil)
      song.save()
      expect(song.room()).to(eq(@room))
    end
  end
end
