require 'rails_helper'

describe 'Admin can edit a league', type: :feature do
  let(:league) { create(:league) }
  let(:admin) { league.creator }
  let(:user) { create(:user) }
  let(:member) do
    league.grant_membership(user)
    user
  end

  context 'admin' do
    it 'redirects to league path - successful update' do
      stub_current_user(admin)
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
    it 'redirects to dashboard - user' do
      stub_current_user(user)
      visit edit_league_path(league)

      expect(current_path).to eq(dashboard_path)
    end

    it 'redirects to dashboard - member' do
      stub_current_user(member)
      visit edit_league_path(league)

      expect(current_path).to eq(dashboard_path)
    end
  end
end
