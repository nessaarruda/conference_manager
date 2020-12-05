require 'rails_helper'

RSpec.describe 'show presentation page' do
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
end
