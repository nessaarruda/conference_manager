# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Conference.destroy_all

FactoryBot.create_list(:conference, rand(5..25))

Conference.all.each do |conference|
  rand(5..25).times do
    FactoryBot.create(:presentation, conference: conference)
  end
end
