require 'rails_helper'

describe 'Admin of a league can create a game', type: :feature do
  let(:season) { create(:season) }
  let(:league) { season.league }
  let(:admin) { league.creator }

  scenario 'it creates and redirects to the game' do
    stub_current_user(admin)
    visit new_league_season_game_path(league, season)

    fill_in 'Date', with: '06/12/1981'
    fill_in 'Buy In', with: '100'
    fill_in 'Attendees', with: '10'
    click_button 'Create Game'

    expect(current_path).to eq(league_season_game_path(league, season, Game.last))
    expect(page).to have_content 'December 6, 1981'
    expect(page).to have_content 'Buy In: $100.00'
    expect(page).to have_content 'Attendees: 10'
  end
end
