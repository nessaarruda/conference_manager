require 'rails_helper'

describe Presentation do
  it 'has a conference' do
    should belong_to :conference
  end

  it 'is deleted when its conference is deleted' do
    conference = create(:conference)
    presentation = create(:presentation, conference: conference)

    Conference.destroy(conference.id)

    expect(Conference.all).to eq([])
    expect(Presentation.all).to eq([])
  end
end
