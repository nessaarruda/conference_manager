require 'rails_helper'

describe 'New Meeting page' do
  it 'has a form to add a new presentation' do
    meeting_room = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")

    visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

    expect(page).to have_content("New Meeting")
    expect(page).to have_selector('form')
    expect(page).to have_text('Meeting name:')
    expect(page).to have_field('mename')
    expect(page).to have_text('Number of Participants:')
    expect(page).to have_field('Number of Participants')
    expect(page).to have_text('Start Time:')
    expect(page).to have_text('End Time')
  end

  it 'has a button to Create Meeting' do
    meeting_room = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")

    visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

    expect(page).to have_button('Create Meeting', type: 'submit')
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      meeting_room = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")
      visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Meetings")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      meeting_room = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")
      visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the meeting_rooms page' do
      meeting_room = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")

      visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the meetings page' do
      meeting_room = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      meeting_1 = meeting_room.meetings.create!(name: "Monday Meeting",
                                  number_of_participants: 10,
                                  start_time: "Monday, 10am",
                                end_time: "1 hour")
      visit "/meeting_rooms/#{meeting_room.id}/meetings/new"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
