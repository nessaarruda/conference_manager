require 'rails_helper'

describe 'presentations index page' do
  it 'can see each presentation in the system including its attributes' do
    presentation_1 = Presentation.create(name: "Keynote Address",
                                         presenter: 'Yukihiro Matsumoto',
                                         conference_id: 1,
                                         category: :keynote,
                                         projector_needed: false
                                        )
    presentation_2 = Presentation.create(name: "Improve Your Technical Writing",
                                         presenter: 'Noel Rappin',
                                         conference_id: 1,
                                         category: :workshop,
                                         projector_needed: true
                                        )
    presentation_3 = Presentation.create(name: "The Future Should be Uneven",
                                         presenter: 'H. Waterhouse',
                                         conference_id: 1,
                                         category: :lecture,
                                         projector_needed: true
                                        )

    visit "/presentations"

    expect(page).to have_content("Presentation List")
    expect(page).to have_table('presentations')
    within_table('presentations') do
      expect(page.all('td')[0]).to have_content("Keynote Address")
      expect(page.all('td')[1]).to have_content("Yukihiro Matsumoto")
      expect(page.all('td')[2]).to have_content(1)
      expect(page.all('td')[3]).to have_content("keynote")
      expect(page.all('td')[4]).to have_content("false")
      expect(page.all('td')[5]).to have_content(presentation_1.created_at)
      expect(page.all('td')[6]).to have_content(presentation_1.updated_at)
      expect(page.all('td')[7]).to have_content("Improve Your Technical Writing")
      expect(page.all('td')[14]).to have_content("The Future Should be Uneven")
    end
  end
end
