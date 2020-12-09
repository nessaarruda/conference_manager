require 'rails_helper'

describe 'Edit Presentation page' do
  it 'has a form to edit the presentation' do
    presentation = create(:presentation)

    visit "presentations/#{presentation.id}/edit"

    expect(page).to have_content("Update #{presentation.name}")
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

  it 'updates the attributes of the presentation' do
    presentation = create(:presentation)

    visit "/presentations/#{presentation.id}"
    click_on("Update Presentation")

    expect(page).to have_button('Update Presentation', type: 'submit')

    fill_in(:name, with: 'The Future of Ruby')
    fill_in(:presenter, with: 'Jeff Casimir')
    select('lecture', from: :category)
    click_on('Update Presentation')

    expect(page).to have_current_path("/presentations/#{presentation.id}")
    expect(page).to have_content("Jeff Casimir")
    expect(page).to have_content("lecture")
  end

  it 'allows you to individual attributes of the presentation' do
    presentation = create(:presentation, presenter: "Barack Obama")

    visit "/presentations/#{presentation.id}"
    click_on("Update Presentation")

    fill_in(:presenter, with: "Michelle Obama")
    click_on('Update Presentation')

    expect(page).to have_content("Michelle Obama")
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the conferences page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      presentation = create(:presentation)

      visit "/presentations/#{presentation.id}/edit"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
