require 'rails_helper'

describe 'Conferences Index' do
  describe 'content' do
    it "can see the name of each parent record in the system" do
      conference_1 = create(:conference)
      conference_2 = create(:conference)

      visit "/conferences"

      expect(page).to have_content("Conference List")
      expect(page).to have_link(conference_1.name, href: "/conferences/#{conference_1.id}")
      expect(page).to have_link(conference_2.name, href: "/conferences/#{conference_2.id}")
    end

    it 'displays records in order by recency of creation' do
      conference_1 = create(:conference, created_at: DateTime.parse("20201101"))
      conference_2 = create(:conference, created_at: DateTime.parse("20201201"))
      conference_4 = create(:conference, created_at: DateTime.parse("20201202"))
      conference_3 = create(:conference, created_at: DateTime.parse("20201203"))

      visit "/conferences"

      expect(conference_2.name).to appear_before(conference_1.name)
      expect(conference_4.name).to appear_before(conference_2.name)
      expect(conference_3.name).to appear_before(conference_4.name)

      conference_5 = create(:conference)

      refresh

      expect(conference_5.name).to appear_before(conference_3.name)
    end

    it 'displays the date each conference was created' do
      conference_1 = create(:conference, created_at: DateTime.parse("20201101"))
      conference_2 = create(:conference, created_at: DateTime.parse("20201201"))

      visit "/conferences"

      expect(page).to have_content(conference_1.created_at.strftime('%m-%d-%Y %H:%M'))
    end
  end

  describe 'filtering options' do
    it 'has a field that allows a user to select records by number of attendees' do
      visit "/conferences"

      expect(page).to have_field(:attendees, type: :number)
    end

    it 'allows the user to select conferences by number of attendees' do
      conference_1 = create(:conference, size: 9800)
      conference_2 = create(:conference, size: 2800)
      conference_3 = create(:conference, size: 4700)
      conference_4 = create(:conference, size: 430)

      visit "/conferences"
      fill_in(:attendees, with: 1000)
      click_on("Only return records with attendance over")

      expect(page).to have_content(conference_1.name)
      expect(page).to have_content(conference_2.name)
      expect(page).to have_content(conference_3.name)
      expect(page).not_to have_content(conference_4.name)

      fill_in(:attendees, with: 5000)
      click_on("Only return records with attendance over")

      expect(page).to have_content(conference_1.name)
      expect(page).not_to have_content(conference_2.name)
      expect(page).not_to have_content(conference_3.name)
      expect(page).not_to have_content(conference_4.name)
    end

    it 'allows the user to sort conferences by number of presentations' do
      conference_1 = create(:conference)
      conference_2 = create(:conference)
      conference_3 = create(:conference)
      conference_4 = create(:conference)
      4.times { create(:presentation, conference: conference_2) }
      3.times { create(:presentation, conference: conference_1) }
      2.times { create(:presentation, conference: conference_4) }
      1.times { create(:presentation, conference: conference_3) }

      visit '/conferences'

      expect(page).to have_link('Sort by Number of Presentations')

      click_on('Sort by Number of Presentations')

      expect(current_path).to eq('/conferences')
      expect(conference_2.name).to appear_before(conference_1.name)
      expect(conference_1.name).to appear_before(conference_4.name)
      expect(conference_4.name).to appear_before(conference_3.name)
      within('#row-0') { expect(page).to have_content("4 presentations") }
      within('#row-1') { expect(page).to have_content("3 presentations") }
      within('#row-2') { expect(page).to have_content("2 presentations") }
      within('#row-3') { expect(page).to have_content("1 presentations") }
    end
  end

  describe 'conference actions' do
    it "has a link to create a new Conference record" do
      visit "/conferences"

      expect(page).to have_link("New Conference", href: '/conferences/new')
    end

    it "navigates to the /conferences/new page from the link to create a new conference" do
      visit "/conferences"

      click_link("New Conference")

      expect(page).to have_current_path('/conferences/new')
    end

    it 'has a link to the edit page for each conference' do
      conference_1 = create(:conference)
      conference_2 = create(:conference)
      conference_3 = create(:conference)
      conference_4 = create(:conference)

      visit '/conferences'

      within('#row-0') { expect(page).to have_link("Update Conference") }
      within('#row-1') { expect(page).to have_link("Update Conference") }
      within('#row-2') { expect(page).to have_link("Update Conference") }
      within('#row-3') { expect(page).to have_link("Update Conference") }

      within('#row-0') { click_on("Update Conference") }

      expect(page).to have_current_path("/conferences/#{conference_4.id}/edit")

      click_on("Update Conference")

      expect(page).to have_current_path("/conferences")
    end

    it 'has a link to delete each conference' do
      conference_1 = create(:conference)
      conference_2 = create(:conference)
      conference_3 = create(:conference)
      conference_4 = create(:conference)

      visit '/conferences'

      within('#row-0') { expect(page).to have_button("Delete Conference") }
      within('#row-1') { expect(page).to have_button("Delete Conference") }
      within('#row-2') { expect(page).to have_button("Delete Conference") }
      within('#row-3') { expect(page).to have_button("Delete Conference") }

      within('#row-0') { click_on("Delete Conference") }

      expect(page).to have_current_path('/conferences')
      expect(page).not_to have_content(conference_4.name)
    end

    it 'deletes dependent presentation records when a conference is deleted' do
      conference = create(:conference)
      presentation = create(:presentation, conference: conference)

      visit '/conferences'

      click_on("Delete Conference")

      expect(page).to have_current_path('/conferences')

      visit('/presentations')

      expect(page).not_to have_content(presentation.name)
    end
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      visit '/conferences'

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      visit '/conferences'

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      visit '/conferences'

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      visit '/conferences'

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      visit '/conferences'

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      visit '/conferences'

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
