require 'rails_helper'

describe 'New Presentation page' do
  it 'has a form to add a new presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    expect(page).to have_content("New Presentation")
    expect(page).to have_selector('form')
    expect(page).to have_text('Presentation name')
    expect(page).to have_field(:name)
    expect(page).to have_text('Presenter')
    expect(page).to have_field(:presenter)
    expect(page).to have_text('Category')
    expect(page).to have_select(:category)
    expect(page).to have_text('Projector needed')
    expect(page).to have_field(:projector_needed)
  end

  it 'has a button to Create Presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    expect(page).to have_button('Create Presentation', type: 'submit')
  end

  it 'creates a new presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    fill_in(:name, with: "Keynote Address")
    fill_in(:presenter, with: "Yukihiro Matsumoto")
    select('keynote', from: :category)
    check(:projector_needed)
    click_on("Create Presentation")

    expect(current_path).to eq("/conferences/#{conference.id}/presentations")
    expect(page).to have_content("Keynote Address")
  end

  it 'projector_needed defaults to false if form box is unchecked' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    fill_in(:name, with: "Keynote Address")
    fill_in(:presenter, with: "Yukihiro Matsumoto")
    select('keynote', from: :category)
    click_on("Create Presentation")

    expect(page).to have_content("false")
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      conference = create(:conference)
      visit "/conferences/#{conference.id}/presentations/new"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
