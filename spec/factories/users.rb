FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@domain.tld" }
  end
end
