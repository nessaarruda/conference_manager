require 'rails_helper'

describe 'Edit Conference page' do
  it 'has a form to edit the attributes of the conference' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}/edit"

    expect(page).to have_content("Update #{conference_1.name}")
    expect(page).to have_selector('form')
    expect(page).to have_text('Conference name:')
    expect(page).to have_field('confname', type: 'text')
    expect(page).to have_text('Organization:')
    expect(page).to have_field('org', type: 'text')
    expect(page).to have_text('Expected attendees:')
    expect(page).to have_field('size', type: 'bigint')
    expect(page).to have_text('Dates:')
    expect(page).to have_field('start', type: 'date')
    expect(page).to have_text('to')
    expect(page).to have_field('end', type: 'date')
  end

  it 'updates the attributes of the conference' do
    conference_1 = create(:conference)


    visit "/conferences/#{conference_1.id}"
    click_on("Update Conference")

    expect(page).to have_button('Update Conference', type: 'submit')

    fill_in('confname', with: 'World Ruby Convention')
    fill_in('org', with: 'Association of Ruby Professionals')
    fill_in('size', with: 4000)
    fill_in('start', with: "2021-01-19")
    fill_in('end', with: "2021-01-23")
    click_on('Update Conference')

    expect(page).to have_current_path("/conferences/#{conference_1.id}")
    expect(page).to have_content("World Ruby Convention")
    expect(page).to have_content("Association of Ruby Professionals")
    expect(page).to have_content("Expected Attendance: 4000")
    expect(page).to have_content("Jan 19, 2021 to Jan 23, 2021")
  end

  it 'allows you to change individual attributes of the conference' do
    conference_1 = create(:conference, start_date: DateTime.parse("2021-01-19"))

    visit "/conferences/#{conference_1.id}"
    click_on("Update Conference")

    fill_in('start', with: "2021-01-17")
    click_on('Update Conference')

    conf_end = conference_1.end_date.strftime("%b %e, %Y")
    expect(page).to have_content("Jan 17, 2021 to #{conf_end}")
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}/edit"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
