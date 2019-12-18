require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

before(:each) do
  Room.clear()
  Song.clear()

end

describe('create an room path', {:type => :feature}) do
  it('creates an room and then goes to the room page') do
    visit('/rooms')
    click_on('Add a new room')
    fill_in('room_name', :with => 'Yellow Submarine')
    click_on('Go!')
    expect(page).to have_content('Yellow Submarine')
  end
end

describe('create song path', {:type => :feature}) do
  it('creates an room and then goes to the room page') do
    room = Room.new("Yellow Submarine", nil, nil, nil, nil)
    room.save
    visit("/rooms/#{room.id}")
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    expect(page).to have_content('All You Need Is Love')
  end
end
