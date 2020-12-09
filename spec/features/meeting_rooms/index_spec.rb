require 'rails_helper'

describe 'as a visitor' do
  describe 'meeting_rooms index page' do
    it "can see the name of each meeting room record in the system" do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )



      visit "/meeting_rooms"

      expect(page).to have_content("Meeting Rooms")
      expect(page).to have_link(meeting_room_1.name, href: "/meeting_rooms/#{meeting_room_1.id}")
    end

    it "has a link to create a new Meeting Room record" do
      visit "/meeting_rooms"

      expect(page).to have_link("New Meeting Room", href: '/meeting_rooms/new')
    end

    it "navigates to the /meeting_room page from the link to create a new meeting room" do
      visit "/meeting_rooms"

      click_link("New Meeting Room")

      expect(page).to have_current_path('/meeting_rooms/new')
    end

    it 'When I visit the index page sorts records datatime by most recently created and I see the created date' do

      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )
      meeting_room_2 = MeetingRoom.create(name: "AOC",
        has_projector: true,
        capacity: 20
      )
      visit '/meeting_rooms'
      expect(meeting_room_2.name).to appear_before(meeting_room_1.name)
    end
  end
  it 'Shows records that have a true value before records that have false' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
      has_projector: true,
      capacity: 30
    )
    meeting_room_2 = MeetingRoom.create(name: "AOC",
      has_projector: false,
      capacity: 20
    )
    visit '/meeting_rooms'

    expect(meeting_room_1.name).to appear_before(meeting_room_2.name)
  end

  it 'shows all records above a given threshold' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
      has_projector: true,
      capacity: 30
    )
    meeting_room_2 = MeetingRoom.create(name: "AOC",
      has_projector: false,
      capacity: 20
    )
    visit '/meeting_rooms'

    expect(page).to have_field("capacity")
    expect(page).to have_button("Only return records with more than minimum capacity")

    fill_in("capacity", with: 25)
    click_on("Only return records with more than minimum capacity")

    expect(page).to have_content(meeting_room_1.name)
    expect(page).not_to have_content(meeting_room_2.name)
  end
  it 'sorts meeting rooms by number of meetings' do
    meeting_room_1 = MeetingRoom.create(name: "AOC",
      has_projector: true,
      capacity: 20
    )
    meeting_room_2 = MeetingRoom.create(name: "Oprah",
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
        visit '/meeting_rooms'
        expect(page).to have_link("Sort by Number of Meetings")
        click_on("Sort by Number of Meetings")
        expect(current_path).to eq('/meeting_rooms')
        expect(meeting_room_1.name).to appear_before(meeting_room_2.name)
        within('#row-0') do
          expect(page).to have_content("2 meetings")
        end
        within('#row-1') do
          expect(page).to have_content("0 meetings")
        end

        it 'has a link to the edit page for each meeting room' do
          meeting_room_1 = MeetingRoom.create(name: "AOC",
            has_projector: true,
            capacity: 20
          )
          meeting_room_2 = MeetingRoom.create(name: "Oprah",
            has_projector: true,
            capacity: 30
          )

          visit '/meeting_rooms'

          within('#row-0') { expect(page).to have_link("Update Meeting Room") }
          within('#row-1') { expect(page).to have_link("Update Meeting Room") }

          within('#row-0') { click_on("Update Meeting Room") }

          expect(page).to have_current_path("/meeting_rooms/#{meeting_room_2.id}/edit?src=index")

          click_on("Update Meeting Room")

          expect(page).to have_current_path("/meeting_rooms")
        end

        it 'has a link to delete each meeting room' do
          meeting_room_1 = MeetingRoom.create(name: "AOC",
            has_projector: true,
            capacity: 20
          )
          meeting_room_2 = MeetingRoom.create(name: "Oprah",
            has_projector: true,
            capacity: 30
          )

          visit '/meeting_rooms'

          within('#row-0') { expect(page).to have_button("Delete Meeting Room") }
          within('#row-1') { expect(page).to have_button("Delete Meeting Room") }


          within('#row-0') { click_on("Delete Meeting Room") }

          expect(page).to have_current_path('/meeting_rooms')
          expect(page).not_to have_content(meeting_room_2.name)
        end

        describe 'site navigation' do
          it 'has a navigation bar with links to other index pages' do
            visit '/meeting_rooms'

            expect(page).to have_link("Conference Manager Home")
            expect(page).to have_link("Conferences")
            expect(page).to have_link("Meeting Rooms")
            expect(page).to have_link("Presentations")
            expect(page).to have_link("Meetings")
          end

          it 'navigates to the welcome page' do
            visit '/meeting_rooms'

            click_on("Conference Manager Home")

            expect(page).to have_current_path('/')
          end

          it 'navigates to the meeting_rooms page' do
            visit '/meeting_rooms'

            click_on("Meeting Rooms")

            expect(page).to have_current_path('/meeting_rooms')
          end

          it 'navigates to the meeting rooms page' do
            visit '/meeting_rooms'

            click_on("Meeting Rooms")

            expect(page).to have_current_path('/meeting_rooms')
          end

          it 'navigates to the meetings page' do
            visit '/meeting_rooms'

            click_on("Meetings")

            expect(page).to have_current_path('/meetings')
          end

          it 'navigates to the meetings page' do
            visit '/meeting_rooms'

            click_on("Meetings")

            expect(page).to have_current_path('/meetings')
          end

          it 'has a link to view all meetings' do
            visit '/meeting_rooms'

            expect(page).to have_link("View All Meetings")
          end

          it 'navigates to meetings index page' do
            visit '/meeting_rooms'

            click_on("View All Meetings")

            expect(page).to have_current_path('/meetings')
          end
        end
      end
    end
