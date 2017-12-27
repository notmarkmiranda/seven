FactoryBot.define do
  factory :player do
    game
    finishing_place 1
    additional_expense 20
    user
    finished_at Time.now

    after(:create) do |player|
      create(:user_league_role, :member, user: player.user, league: player.game.league)
    end
  end
end
