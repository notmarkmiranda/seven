require 'rails_helper'

describe 'Admin can edit a league', type: :feature do
  let(:league) { create(:league) }
  let(:admin) { league.creator }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it 'redirects to league path - successful update' do
    visit edit_league_path(league)

    fill_in 'League Name', with: 'Marks Terrible League'
    click_button 'Update League'

    expect(current_path).to eq(league_path(league.reload))
    expect(page).to have_content('Marks Terrible League')
  end

  it 'redirects to dashboard - visitor'
  it 'redirects to dashboard - member'
end
