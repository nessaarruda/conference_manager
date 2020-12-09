FactoryBot.define do
  factory :meeting_room do
    name { Faker::Artist.name }
    capacity { rand(10..50) }
    has_projector { [true, false].sample }
  end
end
