require 'rails_helper'

describe Conference do
  it 'has presentations' do
    should have_many :presentations
  end

  it 'selects conferences' do
    conference_1 = create(:conference, size: 1000)
    conference_2 = create(:conference, size: 3000)
    conference_3 = create(:conference, size: 2000)
    conference_4 = create(:conference, size: 4000)
    3.times { create(:presentation, conference: conference_2) }
    2.times { create(:presentation, conference: conference_4) }
    1.times { create(:presentation, conference: conference_1) }

    conferences = Conference.select_conferences(2500, "true")
    expected = [conference_2, conference_4]
    expect(conferences).to eq(expected)
    conferences = Conference.select_conferences(2500, nil)
    expected = [conference_4, conference_2]
    expect(conferences).to eq(expected)
    conferences = Conference.select_conferences(nil, "true")
    expected = [conference_2, conference_4, conference_3, conference_1]
    expect(conferences).to eq(expected)
    conferences = Conference.select_conferences(nil, nil)
    expected = [conference_4, conference_3, conference_2, conference_1]
    expect(conferences).to eq(expected)
  end
end
