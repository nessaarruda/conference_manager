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

 it 'displays a count of the number of presentations associated with the conference' do
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
end
