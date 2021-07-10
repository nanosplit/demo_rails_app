feature 'User edit', :devise do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  before(:each) do
    login(user.email, user.password)
  end

  scenario 'user changes email address' do
    visit edit_user_registration_path(user)
    fill_in 'Email', :with => 'newemail@example.com'
    fill_in 'Current password', :with => user.password
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
