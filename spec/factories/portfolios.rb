FactoryBot.define do
  factory :portfolio do
    name { Faker::Company.name }
    website { Faker::Internet.url }
    description { Faker::Lorem.sentence }
    start_date { rand(11..25).days.ago.to_date }
    end_date { rand(1.10).days.ago.to_date }
    actively_working { [true,false].sample }
  end
end
