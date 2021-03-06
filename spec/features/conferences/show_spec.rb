require 'rails_helper'

describe 'Show Conference page' do
  it 'displays the conference with that id and its attributes' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_content(conference_1.name)
    expect(page).to have_content(conference_1.organization)
    expect(page).to have_content(conference_1.size)
    start_date = conference_1.start_date.strftime("%b %d, %Y").strip
    end_date = conference_1.end_date.strftime("%b %d, %Y").strip
    expect(page).to have_content(start_date)
    expect(page).to have_content(end_date)
  end

  it 'has a link to update the conference' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_link("Update Conference", href: "/conferences/#{conference_1.id}/edit")

    click_link("Update Conference")

    expect(page).to have_current_path("/conferences/#{conference_1.id}/edit")
  end

  it 'can delete the conference record' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_button("Delete Conference")

    click_on("Delete Conference")

    expect(page).to have_current_path("/conferences")
    expect(page).not_to have_content(conference_1.name)
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'has a link to view its presentations' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      expect(page).to have_link("View Presentations")

      click_on("View Presentations")

      expect(page).to have_current_path("/conferences/#{conference.id}/presentations")
    end

    it 'has a link to itself' do
      conference = create(:conference)

      visit "/conferences/#{conference.id}"

      expect(page).to have_link(conference.name)

      click_on(conference.name)

      expect(page).to have_current_path("/conferences/#{conference.id}")
    end
  end
end
