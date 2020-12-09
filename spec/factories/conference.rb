FactoryBot.define do
  factory :conference do
    name { "#{Faker::Company.industry} #{["Conference", "Convention","Symposium"].sample}" }
    organization { Faker::Company.name }
    size { rand(50..10000) }
    start_date { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    end_date { Faker::Date.between(from: start_date, to: start_date + 10) }
  end
end
