FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@domain.tld" }
    name { Faker::Name.name }
    password { "password123" }
  end
end
