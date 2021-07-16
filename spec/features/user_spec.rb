require 'rails_helper'

feature 'User management', :devise do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  context "visitor creating account" do
    scenario 'visitor can create a user account with valid name, email, and password' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: 'valid@example.com'
      fill_in 'user_password', with: 'validPass123'
      fill_in 'Password confirmation', with: 'validPass123'
      click_button 'Sign up'

      expect(page).to have_content I18n.t 'devise.registrations.signed_up'
    end

    scenario 'visitor cannot create user account with no name' do
      visit new_user_registration_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'valid@example.com'
      fill_in 'user_password', with: 'validPass123'
      fill_in 'Password confirmation', with: 'validPass123'
      click_button 'Sign up'

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'visitor cannot create user account with no email' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: ''
      fill_in 'user_password', with: 'validPass123'
      fill_in 'Password confirmation', with: 'validPass123'
      click_button 'Sign up'

      expect(page).to have_content "Email can't be blank"
    end

    scenario 'visitor cannot create user account with no password' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: 'valid@example.com'
      fill_in 'user_password', with: ''
      fill_in 'Password confirmation', with: 'validPass123'
      click_button 'Sign up'

      expect(page).to have_content "Password can't be blank"
    end

    scenario 'visitor cannot create user account with invalid email' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: 'badEmail'
      fill_in 'user_password', with: 'validPass123'
      fill_in 'Password confirmation', with: 'validPass123'
      click_button 'Sign up'

      expect(page).to have_content "Email is invalid"
    end

    scenario 'visitor cannot create user account with short password' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: 'valid@example.com'
      fill_in 'user_password', with: 'short'
      fill_in 'Password confirmation', with: 'short'
      click_button 'Sign up'

      expect(page).to have_content "Password is too short"
    end

    scenario 'visitor cannot create user account with mismatched passwords' do
      visit new_user_registration_path
      fill_in 'Name', with: 'User Name'
      fill_in 'Email', with: 'valid@example.com'
      fill_in 'user_password', with: 'validPass123'
      fill_in 'Password confirmation', with: 'invalidPass123'
      click_button 'Sign up'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end

  context "user signing in" do
    scenario 'user cannot sign in if not registered' do
      login('test@test.com', 'asdfasdf')
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
    end

    scenario 'user can sign in with valid credentials' do
      login(user.email, user.password)
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    end

    scenario 'user cannot sign in with wrong email' do
      login('invalid@test.com', user.password)
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
    end

    scenario 'user cannot sign in with wrong password' do
      login(user.email, 'invalidpass')
      expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
    end
  end

  context "user editing their profile" do
    before(:each) do
      login(user.email, user.password)
    end

    scenario 'user changes email address' do
      visit edit_user_registration_path(user)
      fill_in 'Email', with: 'newemail@example.com'
      fill_in 'Current password', with: user.password
      click_button 'Update'

      txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
      expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    end

    scenario "user cannot cannot edit another user's profile", :user do
      visit edit_user_registration_path(user2)
      expect(page).to have_content 'Edit User'
      expect(page).to have_field('Email', with: user.email)
    end
  end

  context "user signing out" do
    scenario 'user signs out successfully' do
      login(user.email, user.password)
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
      click_link 'Sign out'
      expect(page).to have_content I18n.t 'devise.sessions.signed_out'
    end
  end

  context "user deleting account", :js do
    scenario 'user can delete own account' do
      skip 'slow test'

      login(user.email, user.password)
      visit edit_user_registration_path(user)
      click_button 'Cancel my account'

      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content I18n.t 'devise.registrations.destroyed'
    end
  end

end
