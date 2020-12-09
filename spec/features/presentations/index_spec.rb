require 'rails_helper'

describe 'Presentations Index' do
  describe 'content' do
    it 'can show each presentation in the system including its attributes' do
      presentation_1 = create(:presentation)
      presentation_2 = create(:presentation)
      presentation_3 = create(:presentation)

      visit "/presentations"

      expect(page).to have_content("Presentation List")
      expect(page).to have_table('presentations')
      within('#row-0') do
        expect(page).to have_content(presentation_3.name)
        expect(page).to have_content(presentation_3.presenter)
        expect(page).to have_content(presentation_3.category)
        expect(page).to have_content(presentation_3.projector_needed)
        created = presentation_3.created_at.strftime('%m-%d-%Y %H:%M')
        expect(page).to have_content(created)
        updated = presentation_3.updated_at.strftime('%m-%d-%Y %H:%M')
        expect(page).to have_content(updated)
      end
      within('#row-1') { expect(page).to have_content(presentation_2.name) }
      within('#row-2') { expect(page).to have_content(presentation_1.name) }
    end

    it 'can show the presentations associated with a given conference' do
      conference_1 = create(:conference)
      conference_2 = create(:conference)
      presentation_1 = create(:presentation, conference: conference_1)
      presentation_2 = create(:presentation, conference: conference_1)
      presentation_3 = create(:presentation, conference: conference_2)

      visit "/conferences/#{conference_1.id}/presentations"

      expect(page).to have_table('presentations')
      expect(page).to have_content(presentation_1.name)
      expect(page).to have_content(presentation_2.name)
      expect(page).not_to have_content(presentation_3.name)
    end

    it 'displays records in order by recency of creation' do
      presentation_1 = create(:presentation, created_at: DateTime.parse("20201101"))
      presentation_2 = create(:presentation, created_at: DateTime.parse("20201201"))
      presentation_3 = create(:presentation, created_at: DateTime.parse("20201203"))
      presentation_4 = create(:presentation, created_at: DateTime.parse("20201202"))

      visit "/presentations"

      expect(presentation_2.name).to appear_before(presentation_1.name)
      expect(presentation_4.name).to appear_before(presentation_2.name)
      expect(presentation_3.name).to appear_before(presentation_4.name)

      presentation_5 = create(:presentation)

      refresh

      expect(presentation_5.name).to appear_before(presentation_3.name)
    end

    it 'displays the date each presentation was created' do
      presentation_1 = create(:presentation, created_at: DateTime.parse("20201101"))
      presentation_2 = create(:presentation, created_at: DateTime.parse("20201201"))

      visit "/presentations"

      expect(page).to have_content(presentation_1.created_at.strftime('%m-%d-%Y %H:%M'))
    end

    it 'displays a count of the number of presentations associated with the conference' do
      conference = create(:conference)
      presentation_1 = create(:presentation, conference: conference)
      presentation_2 = create(:presentation, conference: conference)
      presentation_3 = create(:presentation, conference: conference)

      visit "/conferences/#{conference.id}/presentations"

      expect(page).to have_content("3 presentations")

      presentation_4 = create(:presentation, conference: conference)
      refresh

      expect(page).to have_content("4 presentations")
    end

    it 'displays presentations with a boolean val of "true" before those with "false"' do
      conference = create(:conference)
      presentation_1 = create(:presentation, conference: conference, projector_needed: false)
      presentation_2 = create(:presentation, conference: conference, projector_needed: true)
      presentation_3 = create(:presentation, conference: conference, projector_needed: false)

      visit "/conferences/#{conference.id}/presentations"

      expect(presentation_2.name).to appear_before(presentation_1.name)
      expect(presentation_2.name).to appear_before(presentation_3.name)
      expect(presentation_3.name).to appear_before(presentation_1.name)
    end
  end

  describe 'filtering options' do
    it 'has a link to sort presentations in alphabetical order by name' do
      conference = create(:conference)
      presentation_1 = create(:presentation, conference: conference)
      presentation_2 = create(:presentation, conference: conference)
      presentation_3 = create(:presentation, conference: conference)

      visit "/conferences/#{conference.id}/presentations"

      expect(page).to have_link("Display in Alphabetical Order by Name")

      click_link("Display in Alphabetical Order by Name")

      expect(current_path).to eq("/conferences/#{conference.id}/presentations")
      sorted_names = [presentation_1.name, presentation_2.name, presentation_3.name].sort
      expect(sorted_names[0]).to appear_before(sorted_names[1])
      expect(sorted_names[1]).to appear_before(sorted_names[2])
    end

    it 'can sort all presentations by alphabetical order' do
      presentation_1 = create(:presentation)
      presentation_2 = create(:presentation)
      presentation_3 = create(:presentation)

      visit "/presentations"

      expect(page).to have_link("Display in Alphabetical Order by Name")

      click_link("Display in Alphabetical Order by Name")

      expect(current_path).to eq("/presentations")
      sorted_names = [presentation_1.name, presentation_2.name, presentation_3.name].sort
      expect(sorted_names[0]).to appear_before(sorted_names[1])
      expect(sorted_names[1]).to appear_before(sorted_names[2])
    end
  end

  describe 'presentation actions' do
    it 'has a link to add a new presentation' do
      conference_1 = create(:conference)

      visit "/conferences/#{conference_1.id}/presentations"

      expect(page).to have_button("Create Presentation")

      click_button("Create Presentation")

      expect(current_path).to eq("/conferences/#{conference_1.id}/presentations/new")
    end

    it 'has links to the edit page for each presentation' do
      presentation_1 = create(:presentation)
      presentation_2 = create(:presentation)
      presentation_3 = create(:presentation)
      presentation_4 = create(:presentation, projector_needed: true)

      visit '/presentations'

      within('#row-0') { expect(page).to have_link("Update Presentation") }
      within('#row-1') { expect(page).to have_link("Update Presentation") }
      within('#row-2') { expect(page).to have_link("Update Presentation") }
      within('#row-3') { expect(page).to have_link("Update Presentation") }

      within('#row-0') { click_on("Update Presentation") }

      expect(page).to have_current_path("/presentations/#{presentation_4.id}/edit?src=index")

      click_on("Update Presentation")

      expect(page).to have_current_path("/presentations")
    end

    it 'has links to edit each presentation from the presentations index of a conference' do
      conference = create(:conference)
      presentation_1 = create(:presentation, conference: conference)
      presentation_2 = create(:presentation, conference: conference)
      presentation_3 = create(:presentation, conference: conference)
      presentation_4 = create(:presentation, conference: conference, projector_needed: true)

      visit "/conferences/#{conference.id}/presentations"

      within('#row-0') { expect(page).to have_link("Update Presentation") }
      within('#row-1') { expect(page).to have_link("Update Presentation") }
      within('#row-2') { expect(page).to have_link("Update Presentation") }
      within('#row-3') { expect(page).to have_link("Update Presentation") }

      within('#row-0') { click_on("Update Presentation") }

      expect(current_path).to eq("/presentations/#{presentation_4.id}/edit")

      click_on("Update Presentation")

      expect(page).to have_current_path("/conferences/#{conference.id}/presentations")
    end

    it 'has links to delete each presentation' do
      presentation_1 = create(:presentation)
      presentation_2 = create(:presentation)
      presentation_3 = create(:presentation)
      presentation_4 = create(:presentation, projector_needed: true)

      visit '/presentations'

      within('#row-0') { expect(page).to have_button("Delete Presentation") }
      within('#row-1') { expect(page).to have_button("Delete Presentation") }
      within('#row-2') { expect(page).to have_button("Delete Presentation") }
      within('#row-3') { expect(page).to have_button("Delete Presentation") }

      within('#row-0') { click_on("Delete Presentation") }

      expect(page).to have_current_path('/presentations')
      expect(page).not_to have_content(presentation_4.name)
    end

    it 'has links to delete presentations on the presentation index of a conference' do
      conference = create(:conference)
      presentation_1 = create(:presentation, conference: conference)
      presentation_2 = create(:presentation, conference: conference)
      presentation_3 = create(:presentation, conference: conference)
      presentation_4 = create(:presentation, conference: conference, projector_needed: true)

      visit "/conferences/#{conference.id}/presentations"

      within('#row-0') { expect(page).to have_button("Delete Presentation") }
      within('#row-1') { expect(page).to have_button("Delete Presentation") }
      within('#row-2') { expect(page).to have_button("Delete Presentation") }
      within('#row-3') { expect(page).to have_button("Delete Presentation") }

      within('#row-0') { click_on("Delete Presentation") }

      expect(page).to have_current_path("/conferences/#{conference.id}/presentations")
      expect(page).not_to have_content(presentation_4.name)
    end
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      visit '/presentations'

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      visit '/presentations'

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      visit '/presentations'

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      visit '/presentations'

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      visit '/presentations'

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      visit '/presentations'

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'has links to navigate to conferences' do
      conference = create(:conference)
      presentation = create(:presentation, conference: conference)

      visit '/presentations'

      expect(page).to have_link(conference.name)

      click_on(conference.name)

      expect(page).to have_current_path("/conferences/#{conference.id}")
    end
  end
end
