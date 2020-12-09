require 'rails_helper'

describe 'New Conference page' do
  it 'displays a form for creating a new conference record' do
    visit '/conferences/new'

    expect(page).to have_content("New Conference")
    expect(page).to have_selector('form')
    expect(page).to have_text('Conference name')
    expect(page).to have_field(:name)
    expect(page).to have_text('Organization')
    expect(page).to have_field(:organization)
    expect(page).to have_text('Expected attendees')
    expect(page).to have_field(:size)
    expect(page).to have_text('Dates')
    expect(page).to have_field(:start_date)
    expect(page).to have_field(:end_date)
  end

  it 'has a button to Create Conference' do
    visit '/conferences/new'

    expect(page).to have_button('Create Conference', type: 'submit')
  end

  it 'creates a new conference and redirects to the conferences index' do
    visit '/conferences/new'

    fill_in(:name, with: 'World Ruby Conference')
    fill_in(:organization, with: 'Ruby Association')
    fill_in(:size, with: 2000)
    fill_in(:start_date, with: "2021-01-19")
    fill_in(:end_date, with: "2021-01-21")
    click_on('Create Conference')

    conference = Conference.find_by(name: 'World Ruby Conference')

    expect(page).to have_current_path('/conferences')
    expect(page).to have_content(conference.name)
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      visit "/conferences/new"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      visit "/conferences/new"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      visit "/conferences/new"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      visit "/conferences/new"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      visit "/conferences/new"

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      visit "/conferences/new"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
