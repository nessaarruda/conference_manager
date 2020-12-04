FactoryBot.define do
  factory :presentation do
    conference
    name { Faker::Company.bs }
    presenter { Faker::Name.name }
    category { rand('keynote','lecture','workshop','panel') }
    projector_needed { rand(true, false) }
  end
end
