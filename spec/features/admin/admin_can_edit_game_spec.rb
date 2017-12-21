require 'rails_helper'

describe 'Admin of league can edit a game', type: :feature do
  let(:game) { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin) { league.creator }

  before do
    stub_current_user(admin)
  end

  scenario 'it allows an admin to edit the game and redirects back to the game' do
    visit edit_league_season_game_path(league, season, game)

    fill_in 'Date', with: '14/7/1980'
    click_button 'Update Game'

    expect(current_path).to eq(league_season_game_path(league, season, game))
    expect(page).to have_content 'July 14, 1980'
  end
end
