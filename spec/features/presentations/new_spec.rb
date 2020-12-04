require 'rails_helper'

RSpec.describe 'new presentation page' do
  it 'has a form to add a new presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    expect(page).to have_content("New Presentation")
    expect(page).to have_selector('form')
    expect(page).to have_text('Presentation name:')
    expect(page).to have_field('presname', type: 'text')
    expect(page).to have_text('Presenter:')
    expect(page).to have_field('presenter', type: 'text')
    expect(page).to have_text('Category:')
    expect(page).to have_select('category')
    expect(page).to have_text('Do you need a projector?')
    expect(page).to have_field('projector', type: 'checkbox')
  end

  it 'has a button to Create Presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    expect(page).to have_button('Create Presentation', type: 'submit')
  end

  it 'creates a new presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    fill_in('presname', with: "Keynote Address")
    fill_in('presenter', with: "Yukihiro Matsumoto")
    select('keynote', from: "category")
    check('projector')
    click_on("Create Presentation")

    expect(current_path).to eq("/conferences/#{conference.id}/presentations")
    expect(page).to have_content("Keynote Address")
  end
end
