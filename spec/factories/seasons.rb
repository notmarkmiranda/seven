FactoryBot.define do
  factory :season do
    league

    trait :active do
      active true
    end

    trait :false do
      active false
    end
  end
end
