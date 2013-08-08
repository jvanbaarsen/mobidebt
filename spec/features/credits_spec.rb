require 'spec_helper'
feature 'Credit Management' do
  scenario 'When i log in as a user with 30 credits, the page says i have 30 credits' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Credits: 30')
  end

  scenario 'When positive credits, the credit amount should be green' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_selector('.text-success')
  end

  scenario 'When negative credits, the credit amount should be red' do
    user = FactoryGirl::create(:user, credits: -10)
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_selector('.text-error')
  end

  scenario 'When i buy a can, the counter should say 2 credits less' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Credits: 30')
    click_link 'Purchase a drink'
    expect(page.body).to have_content('Credits: 28')
  end

  scenario 'Weh i buy a snak, the counter should say 1 credit less' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Credits: 30')
    click_link 'Purchase a snack'
    expect(page.body).to have_content('Credits: 29')
  end

  def user
    @user ||= FactoryGirl::create(:user, credits: 30)
  end
end
