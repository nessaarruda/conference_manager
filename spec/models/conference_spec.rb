require 'rails_helper'

describe Conference do
  it "changes the format of start_date" do
    conference = Conference.new
    conference.start_date = "2020-12-02"
    conference.end_date = "2020-12-03"

    expect(conference.start).to eq("Dec 2, 2020")
    expect(conference.end).to eq("Dec 3, 2020")
  end
end
