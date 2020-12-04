require 'rails_helper'

describe 'edit meeting_rooms page' do
  it 'has a form to edit the attributes of the meeting room' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )

    visit "/meeting_rooms/#{meeting_room_1.id}/edit"

    expect(page).to have_content("Update #{meeting_room_1.name}")
    expect(page).to have_selector('form')
    expect(page).to have_text('Meeting Room name:')
    expect(page).to have_field('metname', type: 'text')
    expect(page).to have_text('Capacity:')
    expect(page).to have_field('capacity', type: 'bigint')
  end

  it 'updates the attributes of the meeting_room' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )

    visit "/meeting_rooms/#{meeting_room_1.id}/edit"

    expect(page).to have_button('Update Meeting Room', type: 'submit')

    fill_in('metname', with: 'Oprah')
    fill_in('capacity', with: 30)
    click_on('Update Meeting')

    expect(page).to have_current_path("/meeting_rooms/#{meeting_room_1.id}")
    expect(page).to have_content("Oprah")
  end
end
