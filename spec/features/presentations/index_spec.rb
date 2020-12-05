require 'rails_helper'

describe 'presentations index page' do
  it 'can show each presentation in the system including its attributes' do
    presentation_1 = create(:presentation)
    presentation_2 = create(:presentation)
    presentation_3 = create(:presentation)

    visit "/presentations"

    expect(page).to have_content("Presentation List")
    expect(page).to have_table('presentations')
    within_table('presentations') do
      expect(page.all('td')[0]).to have_content(presentation_1.name)
      expect(page.all('td')[1]).to have_content(presentation_1.presenter)
      expect(page.all('td')[2]).to have_content(presentation_1.category)
      expect(page.all('td')[3]).to have_content(presentation_1.projector_needed)
      expect(page.all('td')[4]).to have_content(presentation_1.created_at)
      expect(page.all('td')[5]).to have_content(presentation_1.updated_at)
      expect(page.all('td')[6]).to have_content(presentation_2.name)
      expect(page.all('td')[12]).to have_content(presentation_3.name)
    end
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

  it 'has a link to add a new presentation' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}/presentations"

    expect(page).to have_button("Create Presentation")

    click_button("Create Presentation")

    expect(current_path).to eq("/conferences/#{conference_1.id}/presentations/new")
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
end
