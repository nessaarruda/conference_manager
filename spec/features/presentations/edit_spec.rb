require 'rails_helper'

describe 'edit presentation page' do
  it 'has a form to edit the presentation' do
    presentation = create(:presentation)

    visit "presentations/#{presentation.id}/edit"

    expect(page).to have_content("Update #{presentation.name}")
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

  it 'updates the attributes of the presentation' do
    presentation = create(:presentation)

    visit "/presentations/#{presentation.id}/edit"

    expect(page).to have_button('Update Presentation', type: 'submit')

    fill_in('presname', with: 'The Future of Ruby')
    fill_in('presenter', with: 'Jeff Casimir')
    select('lecture', from: "category")
    click_on('Update Presentation')

    expect(page).to have_current_path("/presentations/#{presentation.id}")
    expect(page).to have_content("Jeff Casimir")
    expect(page).to have_content("lecture")
    expect(page).to have_content("false")
  end

  it 'allows you to individual attributes of the presentation' do
    presentation = create(:presentation, presenter: "Barack Obama")

    visit "/presentations/#{presentation.id}/edit"

    fill_in('presenter', with: "Michelle Obama")
    click_on('Update Presentation')

    expect(page).to have_content("Michelle Obama")
  end
end
