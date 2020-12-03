require 'rails_helper'

describe 'as a visitor' do
  describe 'new conference record page' do
    it 'displays a form for creating a new conference record' do
      visit '/conferences/new'

      expect(page).to have_content("New Conference")
      expect(page).to have_selector('form')
      expect(page).to have_text('Conference name:')
      expect(page).to have_field('confname', type: 'text')
      expect(page).to have_text('Organization:')
      expect(page).to have_field('org', type: 'text')
      expect(page).to have_text('Expected attendees:')
      expect(page).to have_field('size', type: 'bigint')
      expect(page).to have_text('Dates:')
      expect(page).to have_field('start', type: 'date')
      expect(page).to have_text('to')
      expect(page).to have_field('end', type: 'date')
    end

    it 'has a button to Create Conference' do
      visit '/conferences/new'

      expect(page).to have_button('Create Conference', type: 'submit')
    end

    it 'creates a new conference and redirects to the conferences index' do
      visit '/conferences/new'

      fill_in('confname', with: 'World Ruby Conference')
      fill_in('org', with: 'Ruby Association')
      fill_in('size', with: 2000)
      fill_in('start', with: "2021-01-19")
      fill_in('end', with: "2021-01-21")
      click_on('Create Conference')

      expect(page).to have_current_path('/conferences')
      expect(page).to have_content("World Ruby Conference")
    end
  end
end
