FactoryBot.define do
  factory :game do
    date Date.new(1981, 12, 6)
    buy_in 100
    completed false
    season
    attendees 10
  end
end
