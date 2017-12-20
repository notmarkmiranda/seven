require 'rails_helper'

describe 'User can create a league', type: :feature do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_league_path
    fill_in 'League Name', with: 'Marks Super Fun League'
  end

  it 'redirects the user to the league page - successful private league create' do
    choose('league_privated_1')
    click_button 'Create League'

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content(League.last.name)
    expect(page).to have_content('Private: true')
  end

  it 'redirects the user to the league page - successful non-private league create' do
    choose('league_privated_0')
    click_button 'Create League'

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content(League.last.name)
    expect(page).to have_content('Private: false')
  end
end
