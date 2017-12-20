require 'rails_helper'

describe 'User can edit their own profile', type: :feature do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'redirects back to dashboard - successful update' do
    visit edit_profile_path

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    click_button 'Update Profile'

    expect(current_path).to eq(dashboard_path)
  end

  scenario 'renders the edit template - unsuccessful update' do
    visit edit_profile_path

    fill_in 'First Name', with: ''
    click_button 'Update Profile'

    expect(page).to have_button 'Update Profile'
  end
end
