require 'rails_helper.rb'
# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
describe 'As a visitor' do
  describe 'When I visit the MeetingRooms Index page' do
    describe 'I see a link to create a new meeting room' do
      it 'When I click on the link it takes me to /meeting_rooms/new' do

        visit "meeting_rooms"

        expect(page).to have_link('Create New Meeting Room')

        click_link('Create New Meeting Room')

        expect(current_path).to eq('/meeting_rooms/new')

      end
    end
  end
end

# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.
