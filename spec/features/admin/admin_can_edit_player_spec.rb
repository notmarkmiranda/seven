require 'rails_helper'

describe 'Admin can edit player', type: :feature do
  let(:user1)  { create(:user, first_name: 'Mark', last_name: 'Miranda') }
  let(:player) { create(:player, user: user1) }
  let(:game)   { player.game }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }
  let!(:member) do
    user = create(:user, first_name: 'Holly', last_name: 'Miranda')
    league.grant_membership(user)
    user
  end

  scenario 'redirects to player after editing' do
    stub_current_user(admin)
    visit edit_league_season_game_player_path(league, season, game, player)

    select member.full_name, from: 'Player Name'
    click_button 'Score Player'

    expect(current_path).to eq(league_season_game_player_path(league, season, game, player))
    expect(page).to have_content member.full_name
    expect(page).to have_content 'Additional Expense: $20.00'
  end
end
