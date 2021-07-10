feature 'User delete', :devise, :js do
  let(:user) { create(:user) }

  scenario 'user can delete own account' do
    skip 'slow test'

    login(user.email, user.password)
    visit edit_user_registration_path(user)
    click_button 'Cancel my account'

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

end
