require 'rails_helper'

describe Presentation do
  it 'has a conference' do
    should belong_to :conference
  end
end
