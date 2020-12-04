require 'rails_helper.rb'

describe 'When I visit the MeetingRooms Index page' do
  it 'I see a link to create a new meeting room' do

    visit "/meeting_rooms"
    expect(page).to have_link('Create New Meeting Room')
  end

    it 'When I click on the link it takes me to /meeting_rooms/new' do
      visit "/meeting_rooms"
      click_link('Create New Meeting Room')
      expect(current_path).to eq('/meeting_rooms/new')
    end
  end
  describe 'When I am on the new page I see a form for creating a new meeting room record' do
    describe 'When I fill out the form with the new meeting room attributes' do
      describe 'When I click the button "Create New Meeting Room" to submit the form' do
        it 'Saves the meeting room and redirects me to /meeting_rooms/' do

          visit 'meeting_rooms/new'
      end
    end
  end
end
#
#
#   end
# end




# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.
