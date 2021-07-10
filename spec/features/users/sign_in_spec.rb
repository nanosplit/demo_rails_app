require 'rails_helper'

feature 'Sign in', :devise do
  let(:user) { create(:user) }

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
