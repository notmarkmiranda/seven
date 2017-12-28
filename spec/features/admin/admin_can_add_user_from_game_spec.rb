require 'rails_helper'

describe 'Admin can add user from game', type: :feature do
  let(:game)   { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }

  before do
    stub_current_user(admin)
    visit new_league_season_game_player_path(league, season, game)

    click_link 'Add a Player'
    fill_in 'Email Address', with: 'poker@player.com'
    fill_in 'First Name', with: 'Poker'
    fill_in 'Last Name', with: 'Shark'
    find(:css, '#invite_user').set(true)
    find(:css, '#admin').set(true)
  end

  scenario 'and finishes at the same time' do
    fill_in 'Additional Expense', with: '75'

    click_button 'Save and Finish Player'

    expect(current_path).to eq(new_league_season_game_player_path(league, season, game))
    expect(page).to have_content 'Poker Shark'
    expect(page).to have_content 'Additional Expense: $75.00'
  end

  scenario 'just adds a user and adds them to the list' do
    click_button 'Just Save Player'

    expect(current_path).to eq(new_league_season_game_player_path(league, season, game))
    expect(page).to_not have_content 'Additional Expense: $75.00'
    expect(page).to have_select("player_user_id", with_options: [admin.full_name, 'Poker Shark'])
  end
end
