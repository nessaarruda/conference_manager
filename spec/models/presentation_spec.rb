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

  it 'selects presentations' do
    3.times do
      conference = create(:conference)
      5.times do
        create(:presentation, conference: conference)
      end
    end
    conference = Conference.first

    presentations = Presentation.select_presentations({id: conference.id, sort: :name})
    expect(presentations.to_set).to eq(conference.presentations.to_set)
    expect(presentations.sort_by {|p| p.name}).to eq(presentations)

    presentations = Presentation.select_presentations({id: conference.id})
    expect(presentations.to_set).to eq(conference.presentations.to_set)

    presentations = Presentation.select_presentations({sort: :name})
    expect(presentations.to_set).to eq(Presentation.all.to_set)
    expect(presentations.sort_by {|p| p.name}).to eq(presentations)

    presentations = Presentation.select_presentations({})
    expect(presentations.to_set).to eq(Presentation.all.to_set)
  end

  it 'titleizes attributes' do
    presentation = create(:presentation, name: 'evolve best of breed eyeballs')

    expect(presentation.name).to eq("Evolve Best Of Breed Eyeballs")
  end
end
