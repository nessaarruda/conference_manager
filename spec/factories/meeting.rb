FactoryBot.define do
  factory :meeting do
    meeting_room
    name { Faker::Hipster.sentence(word_count: 3) }
    number_of_participants { rand(10..50)}
    start_time { Faker::Time.between(from: DateTime.now, to: 1.month.from_now) }
    end_time { Faker::Time.between(from: start_time, to: start_time + 1) }
  end
end
