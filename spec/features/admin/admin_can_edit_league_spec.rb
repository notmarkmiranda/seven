require 'rails_helper'

describe 'Admin can edit a league', type: :feature do
  let(:league) { create(:league) }
  let(:admin) { league.creator }

  context 'admin' do
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
  end

  context 'visitor' do
    it 'redirects to dashboard' do
      visit edit_league_path(league)

      expect(current_path).to eq(sign_in_path)
    end
  end

  context 'member/non-admin' do
    it 'redirects to dashboard'
  end
end
