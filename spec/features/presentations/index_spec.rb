require 'rails_helper'

describe 'presentations index page' do
  it 'can see each presentation in the system including its attributes' do
    presentation_1 = create(:presentation)
    presentation_2 = create(:presentation)
    presentation_3 = create(:presentation)

    visit "/presentations"

    expect(page).to have_content("Presentation List")
    expect(page).to have_table('presentations')
    within_table('presentations') do
      expect(page.all('td')[0]).to have_content(presentation_1.name)
      expect(page.all('td')[1]).to have_content(presentation_1.presenter)
      expect(page.all('td')[2]).to have_content(presentation_1.conference_id)
      expect(page.all('td')[3]).to have_content(presentation_1.category)
      expect(page.all('td')[4]).to have_content(presentation_1.projector_needed)
      expect(page.all('td')[5]).to have_content(presentation_1.created_at)
      expect(page.all('td')[6]).to have_content(presentation_1.updated_at)
      expect(page.all('td')[7]).to have_content(presentation_2.name)
      expect(page.all('td')[14]).to have_content(presentation_3.name)
    end
  end
end
