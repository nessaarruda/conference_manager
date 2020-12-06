require 'rails_helper'

describe 'Show Presentation page' do
  it 'displays the presentation with a given id and its attributes' do
    presentation = create(:presentation)

    visit "/presentations/#{presentation.id}"

    expect(page).to have_content(presentation.name)
    expect(page).to have_content(presentation.presenter)
    expect(page).to have_content(presentation.category)
    expect(page).to have_content(presentation.projector_needed)
    expect(page).to have_content(presentation.conference.name)
  end

  it 'has a link to update the presentation' do
    presentation = create(:presentation)

    visit "/presentations/#{presentation.id}"

    expect(page).to have_link('Update Presentation')

    click_link('Update Presentation')

    expect(current_path).to eq("/presentations/#{presentation.id}/edit")
  end

  it 'can delete the presentation record' do
    presentation = create(:presentation)

    visit "/presentations/#{presentation.id}"

    expect(page).to have_button("Delete Presentation")

    click_on("Delete Presentation")

    expect(page).to have_current_path("/presentations")
    expect(page).not_to have_content(presentation.name)
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
    end

    it 'navigates to the welcome page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'has a link to view its conference' do
      conference = create(:conference)
      presentation = create(:presentation, conference: conference)

      visit "/presentations/#{presentation.id}"

      expect(page).to have_link(conference.name)

      click_on(conference.name)

      expect(page).to have_current_path("/conferences/#{conference.id}")
    end
  end
end
