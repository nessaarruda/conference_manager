require 'rails_helper'

describe 'As a User' do
  describe 'When I visit /' do
    it 'Displays welcome message' do
    visit '/'

    expect(page).to have_content('Welcome to Conference Manager')
    expect(page).to have_content('Conferences')
    end
  end
end
