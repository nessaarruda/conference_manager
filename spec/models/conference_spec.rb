require 'rails_helper'

describe Conference do
  it 'has presentations' do
    should have_many :presentations
  end
end
