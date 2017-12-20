require 'rails_helper'

describe 'User can log in', type: :feature do
  let(:user) { create(:user) }

  before do
    visit sign_in_path

    fill_in 'Email Address', with: user.email
  end

  scenario 'redirects to the dashboard - successful log in' do
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(current_path).to eq(dashboard_path)
  end

  scenario 'renders the sign in page - unsuccessful log in' do
    fill_in 'Password', with: 'passwordz'
    click_button 'Log In'

    expect(page).to have_button 'Log In'
  end

  scenario 'redirects to root path - log out' do
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    click_link 'Log Out'

    expect(current_path).to eq(root_path)
  end
end
