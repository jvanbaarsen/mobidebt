require 'spec_helper'
feature 'Authenticating' do
  scenario 'Sign-up with valid information' do
    visit sign_up_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_password', with: 'secret'
    expect {click_button "Sign up"}.to change {User.count}.by(1)
    expect(current_path).to eq(login_path)
    expect(page.body).to have_content("Account created! Please login")
  end

  scenario 'Sign in' do
    visit login_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'secret'
    click_button "Login"
    expect(page.body).to have_content("Welcome #{user.name}")
  end

  scenario 'Log out' do
    login_user_post(user.email, 'secret')
    visit '/'
    click_link 'Logout'
    expect(page.body).to have_content('See you later, alligator')
  end

  scenario 'Cant enter login when allready logged in' do
    login_user_post(user.email, 'secret')
    visit login_path
    expect(current_path).to eq(dashboard_path)
  end

  scenario 'Page should not have logout link when logged out' do
    visit root_path
    expect(page.body).not_to have_content('Logout')
  end

  def user
    @user ||= FactoryGirl.create(:user)
  end
end
