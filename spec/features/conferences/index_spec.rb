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

  it 'displays records in order by recency of creation' do
    conference_1 = create(:conference, created_at: DateTime.parse("20201101"))
    conference_2 = create(:conference, created_at: DateTime.parse("20201201"))
    conference_3 = create(:conference, created_at: DateTime.parse("20201203"))
    conference_4 = create(:conference, created_at: DateTime.parse("20201202"))

    visit "/conferences"

    expect(conference_2.name).to appear_before(conference_1.name)
    expect(conference_4.name).to appear_before(conference_2.name)
    expect(conference_3.name).to appear_before(conference_4.name)

    conference_5 = create(:conference)

    refresh

    expect(conference_5.name).to appear_before(conference_3.name)
  end

  it 'displays the date each conference was created' do
    conference_1 = create(:conference, created_at: DateTime.parse("20201101"))
    conference_2 = create(:conference, created_at: DateTime.parse("20201201"))

    visit "/conferences"

    expect(page).to have_content(conference_1.created_at.strftime('%m-%d-%Y %H:%M'))
  end

  it 'has a field that allows a user to select records above a user-defined number of attendees' do
    visit "/conferences"

    expect(page).to have_field('number_filter', type: 'bigint')
  end

  it 'allows the user to select conferences by number of attendees' do
    conference_1 = create(:conference, size: 9800)
    conference_2 = create(:conference, size: 2800)
    conference_3 = create(:conference, size: 4700)
    conference_4 = create(:conference, size: 430)

    visit "/conferences"
    fill_in('number_filter', with: 1000)
    click_on('filter_button')

    expect(page).to have_content(conference_1.name)
    expect(page).to have_content(conference_2.name)
    expect(page).to have_content(conference_3.name)
    expect(page).not_to have_content(conference_4.name)

    fill_in('number_filter', with: 5000)
    click_on('filter_button')

    expect(page).to have_content(conference_1.name)
    expect(page).not_to have_content(conference_2.name)
    expect(page).not_to have_content(conference_3.name)
    expect(page).not_to have_content(conference_4.name)
  end

  it 'allows the user to sort conferences by number of presentations' do
    conference_1 = create(:conference)
    conference_2 = create(:conference)
    conference_3 = create(:conference)
    conference_4 = create(:conference)
    4.times { create(:presentation, conference: conference_2) }
    3.times { create(:presentation, conference: conference_1) }
    2.times { create(:presentation, conference: conference_4) }
    1.times { create(:presentation, conference: conference_3) }

    visit '/conferences'

    expect(page).to have_link('Sort by Number of Presentations')

    click_on('Sort by Number of Presentations')

    expect(current_path).to eq('/conferences')
    expect(conference_2.name).to appear_before(conference_1.name)
    expect(conference_1.name).to appear_before(conference_4.name)
    expect(conference_4.name).to appear_before(conference_3.name)
    within('#row-0') { expect(page).to have_content("4 presentations") }
    within('#row-1') { expect(page).to have_content("3 presentations") }
    within('#row-2') { expect(page).to have_content("2 presentations") }
    within('#row-3') { expect(page).to have_content("1 presentations") }
  end
end
