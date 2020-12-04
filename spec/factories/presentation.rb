FactoryBot.define do
  factory :presentation do
    conference
    name { Faker::Company.bs.titleize }
    presenter { Faker::Name.name.titleize }
    category { ['keynote','lecture','workshop','panel'].sample }
    projector_needed { [true, false].sample }
  end
end
