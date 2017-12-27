require 'rails_helper'

describe 'Admin can create a player', type: :feature do
  let(:game) { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin) { league.creator }

  scenario 'redirects to new player after creation' do
    stub_current_user(admin)
    visit new_league_season_game_player_path(league, season, game)

    expect(page).to have_content('No players yet.')
    select admin.full_name, from: 'Player Name'
    fill_in 'Additional Expense', with: '25'
    click_button 'Score Player'

    expect(current_path).to eq(new_league_season_game_player_path(league, season, game))
    expect(page).to_not have_content('No players yet.')
    expect(page).to have_content admin.full_name
    expect(page).to have_content 'Additional Expense: $25.00'
  end
end
