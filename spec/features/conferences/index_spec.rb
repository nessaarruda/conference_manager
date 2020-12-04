require 'rails_helper'

describe 'index conferences page' do
  it "can see the name of each parent record in the system" do
    conference_1 = create(:conference)
    conference_2 = create(:conference)

    visit "/conferences"

    expect(page).to have_content("Conference List")
    expect(page).to have_link(conference_1.name, href: "/conferences/#{conference_1.id}")
    expect(page).to have_link(conference_2.name, href: "/conferences/#{conference_2.id}")
  end

  it "has a link to create a new Conference record" do
    visit "/conferences"

    expect(page).to have_link("New Conference", href: '/conferences/new')
  end

  it "navigates to the /conferences page from the link to create a new conference" do
    visit "/conferences"

    click_link("New Conference")

    expect(page).to have_current_path('/conferences/new')
  end
end
