require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /meetings' do
    it 'Shows the meeting and its attributes' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")
    visit '/meetings'

    expect(page).to have_content("Meetings")
    expect(page).to have_content(meeting_1.name)
    expect(page).to have_content(meeting_1.start_time)
    expect(page).to have_content(meeting_1.number_of_participants)
    expect(page).to have_content(meeting_1.end_time)
    end
  end

  it 'can show the meetings associated with a given meeting_room' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")

    visit "/meeting_rooms/#{meeting_1.id}/meetings"

    expect(page).to have_content(meeting_1.name)
  end

  it 'has a link to add a new meeting' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )

    meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")


   visit "/meeting_rooms/#{meeting_room_1.id}/meetings"

   expect(page).to have_link("Create Meeting")

   click_link("Create Meeting")

   expect(current_path).to eq("/meeting_rooms/#{meeting_room_1.id}/meetings/new")
 end

 it 'displays a count of the number of meetings associated with the conference' do
   meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                   has_projector: true,
                                   capacity: 30
                                 )
   meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                               number_of_participants: 10,
                               start_time: "Monday, 10am",
                             end_time: "1 hour")

     visit "/meeting_rooms/#{meeting_room_1.id}/meetings"

     expect(page).to have_content("1 meetings")
   end

   it 'shows all records above a given threshold' do
     meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                     has_projector: true,
                                     capacity: 30
                                   )
     meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                 number_of_participants: 10,
                                 start_time: "Monday, 10am",
                                 end_time: "1 hour")
     meeting_2 = meeting_room_1.meetings.create!(name: "Tuesday Meeting",
                                 number_of_participants: 15,
                                 start_time: "Tuesday, 10am",
                                 end_time: "1 hour")

     visit '/meetings'

     expect(page).to have_field("number_of_participants")
     expect(page).to have_button("Only return records with more than minimum participants")

     fill_in("number_of_participants", with: 12)
     click_on("Only return records with more than minimum participants")

     expect(page).to have_content(meeting_2.name)
     expect(page).not_to have_content(meeting_1.name)
   end

   it 'sorts meetings in alphabetical order' do
     meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                     has_projector: true,
                                     capacity: 30
                                   )
     meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                 number_of_participants: 10,
                                 start_time: "Monday, 10am",
                                 end_time: "1 hour")
     meeting_2 = meeting_room_1.meetings.create!(name: "Tuesday Meeting",
                                 number_of_participants: 15,
                                 start_time: "Tuesday, 10am",
                                 end_time: "1 hour")
      visit "/meeting_rooms/#{meeting_room_1.id}/meetings"
      expect(page).to have_link("Sort Meetings Alphabetically")
      click_on("Sort Meetings Alphabetically")
      expect(current_path).to eq("/meeting_rooms/#{meeting_room_1.id}/meetings")
      expect(meeting_1.name).to appear_before(meeting_2.name)
   end

   it 'has links to the edit page for each meeting' do
     meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                     has_projector: true,
                                     capacity: 30
                                   )
     meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                 number_of_participants: 10,
                                 start_time: "Monday, 10am",
                                 end_time: "1 hour")
     meeting_2 = meeting_room_1.meetings.create!(name: "Tuesday Meeting",
                                 number_of_participants: 15,
                                 start_time: "Tuesday, 10am",
                                 end_time: "1 hour")
     visit '/meetings'

     within('#row-0') { expect(page).to have_link("Update Meeting") }
     within('#row-1') { expect(page).to have_link("Update Meeting") }

     within('#row-0') { click_on("Update Meeting") }

     expect(page).to have_current_path("/meetings/#{meeting_2.id}/edit?src=index")

     click_on("Update Meeting")

     expect(page).to have_current_path("/meetings")
   end

   it 'has links to delete each presentation' do
     meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                     has_projector: true,
                                     capacity: 30
                                   )
     meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                 number_of_participants: 10,
                                 start_time: "Monday, 10am",
                                 end_time: "1 hour")
     meeting_2 = meeting_room_1.meetings.create!(name: "Tuesday Meeting",
                                 number_of_participants: 15,
                                 start_time: "Tuesday, 10am",
                                 end_time: "1 hour")
     visit '/meetings'

     within('#row-0') { expect(page).to have_button("Delete Meeting") }
     within('#row-1') { expect(page).to have_button("Delete Meeting") }

     within('#row-0') { click_on("Delete Meeting") }

     expect(page).to have_current_path('/meetings')
     expect(page).not_to have_content(meeting_2.name)
     end

    describe 'site navigation' do
      it 'has a navigation bar with links to other index pages' do
        visit '/meetings'

        expect(page).to have_link("Conference Manager Home")
        expect(page).to have_link("Conferences")
        expect(page).to have_link("Meeting Rooms")
        expect(page).to have_link("Presentations")
        expect(page).to have_link("Meetings")
      end

      it 'navigates to the welcome page' do
        visit '/meetings'

        click_on("Conference Manager Home")

        expect(page).to have_current_path('/')
      end

      it 'navigates to the meeting_rooms page' do
        visit '/meetings'

        click_on("Conferences")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the meeting rooms page' do
        visit '/meetings'

        click_on("Meeting Rooms")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the meetings page' do
        visit '/meetings'

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end

      it 'navigates to the meetings page' do
        visit '/meetings'

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end

      it 'has links to navigate to meeting_rooms' do
        meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                        has_projector: true,
                                        capacity: 30
                                      )
        meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                    number_of_participants: 10,
                                    start_time: "Monday, 10am",
                                  end_time: "1 hour")

        visit '/meetings'

        expect(page).to have_link(meeting_room.name)

        click_on(meeting_room.name)

        expect(page).to have_current_path("/meeting_rooms/#{meeting.id}")
      end
    end
  end
