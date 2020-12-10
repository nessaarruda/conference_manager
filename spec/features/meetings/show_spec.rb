require 'rails_helper'

RSpec.describe 'show meeting page' do
  it 'displays the meeting with a given id and its attributes' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")

    visit "/meetings/#{meeting_1.id}"

    expect(page).to have_content(meeting_1.name)
    expect(page).to have_content(meeting_1.number_of_participants)
    start = meeting_1.start_time.strftime('%m-%d-%Y %H:%M')
    expect(page).to have_content(start)
    end_time = meeting_1.end_time.strftime('%m-%d-%Y %H:%M')
    expect(page).to have_content(end_time)
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the meeting_rooms page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the meeting rooms page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the meetings page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'navigates to the meetings page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'has a link to view its meeting_room' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      expect(page).to have_link(meeting_room_1.name)

      click_on(meeting_room_1.name)

      expect(page).to have_current_path("/meeting_rooms/#{meeting_room_1.id}")
    end

    it 'has a link to itself' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meetings/#{meeting_1.id}"

      expect(page).to have_link(meeting_1.name)

      click_on(meeting_1.name)

      expect(page).to have_current_path("/meetings/#{meeting_1.id}")
    end
  end
end
