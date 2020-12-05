require 'rails_helper'

describe 'show conference page' do
  it 'displays the conference with that id and its attributes' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_content(conference_1.name)
    expect(page).to have_content(conference_1.organization)
    expect(page).to have_content(conference_1.size)
    conf_start = conference_1.start_date.strftime("%b %e, %Y")
    conf_end = conference_1.end_date.strftime("%b %e, %Y")
    expect(page).to have_content(conf_start.strip)
    expect(page).to have_content(conf_end)
  end

  it 'has a link to update the conference' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_link("Update Conference", href: "/conferences/#{conference_1.id}/edit")

    click_link("Update Conference")

    expect(page).to have_current_path("/conferences/#{conference_1.id}/edit")
  end

  it 'can delete the conference record' do
    conference_1 = create(:conference)

    visit "/conferences/#{conference_1.id}"

    expect(page).to have_button("Delete Conference")

    click_on("Delete Conference")

    expect(page).to have_current_path("/conferences")
    expect(page).not_to have_content(conference_1.name)
  end
end
