FactoryBot.define do
  factory :league do
    sequence :name { |x| "league number #{x}" }
    sequence :slug { |x| "league-number-#{x}" }
    privated false
    creator
  end
end
