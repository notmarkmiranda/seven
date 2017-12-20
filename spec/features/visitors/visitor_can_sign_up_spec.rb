require 'rails_helper'

describe 'Visitor can sign up', type: :feature do
  scenario 'redirects user to dashboard path - successful create' do
    visit sign_up_path

    fill_in 'First Name', with: 'Mark'
    fill_in 'Last Name', with: 'Miranda'
    fill_in 'Email Address', with: 'markmiranda@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'

    expect(current_path).to eq(dashboard_path)
  end

  scenario 'renders the new template - unsuccessful create' do
    visit sign_up_path

    fill_in 'First Name', with: 'Mark'
    fill_in 'Email Address', with: 'markmiranda@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_button 'Sign Up'
  end
end
