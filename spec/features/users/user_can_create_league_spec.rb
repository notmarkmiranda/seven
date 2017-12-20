require 'rails_helper'

describe 'User can create a league', type: :feature do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'redirects the user to the league page - successful create' do
    visit new_league_path

    fill_in 'League Name', with: 'Marks Super Fun League'
    click_button 'Create League'

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content(League.last.name)
  end
end
