require 'spec_helper'
feature 'Credit Management' do
  scenario 'When i log in as a user with 30 drink credits, the page says i have 30 drink credits' do
    user = FactoryGirl.create(:user, drink_credits: 30)
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Drink credits: 30')
  end

  scenario 'When i log in as a user with 10 snack credits, the page says i have 10 snack credits' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Snack credits: 10')
  end

  scenario 'When i log in as a user with -10 snack and drink credits, the page should say i have a debt of 11 EURO' do
    user = FactoryGirl.create(:user, snack_credits: -10, drink_credits: -10)
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Total: -€11.00')
  end

  scenario 'When positive credits, the credit amount should be green' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_selector('.text-success')
  end

  scenario 'When negative credits, the credit amount should be red' do
    user = FactoryGirl::create(:user, drink_credits: -10)
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_selector('.text-error')
  end

  scenario 'When i buy a can, the counter should say 1 credits less' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Drink credits: 20')
    click_link 'Purchase a drink'
    expect(page.body).to have_content('Drink credits: 19')
  end

  scenario 'When i buy a snack, the counter should say 1 snack credit less' do
    login_user_post(user.email, 'secret')
    visit root_path
    expect(page.body).to have_content('Snack credits: 10')
    click_link 'Purchase a snack'
    expect(page.body).to have_content('Snack credits: 9')
  end

  scenario 'Editing your balance' do
    login_user_post(user.email, 'secret')
    visit root_path
    click_link 'Edit balance'
    expect(current_path).to eq(edit_balance_path)
    fill_in 'user_snack_credits', with: 100
    fill_in 'user_drink_credits', with: 90
    click_button 'Save balance'
    user.reload
    expect(user.snack_credits).to eq(100)
    expect(user.drink_credits).to eq(90)
    expect(page.body).to have_content('Balance has been updated')
  end
end

feature 'Credit overview' do
  scenario 'When i visit the overview page, i wanna see a list of all the users with their debt' do
    login_user_post(user.email, 'secret')
    FactoryGirl.create(:user, snack_credits: -5, drink_credits: -3, name: 'Johny', email: 'jonhy@example.com')
    visit users_path
    expect(page.body).to have_content('Johny')
  end
end

def user
  @user ||= FactoryGirl::create(:user)
end
