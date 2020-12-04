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
    expect(page).to have_selector('category', type: 'option')
    expect(page).to have_text('Do you need a projector?')
    expect(page).to have_selector('projector', type: 'radio')
  end

  it 'has a button to Create Presentation' do
    visit '/presentation/new'

    expect(page).to have_button('Create Presentation', type: 'submit')
  end

  it 'creates a new presentation' do
    conference = create(:conference)

    visit "/conferences/#{conference.id}/presentations/new"

    fill_in('presname', with: "Keynote Address")
    fill_in('presenter', with: "Yukihiro Matsumoto")
    fill_in('category', with: "keynote")
    fill_in('projector', with: "yes")
    click_on("Create Presentation")

    expect(current_path).to eq("/conferences/#{conference.id}/presentations")
    expect(page).to have_content("Keynote Address")
  end
end
