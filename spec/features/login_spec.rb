require 'spec_helper'

feature "Log in." do
  scenario 'Log in via form' do
    user = FactoryGirl.create(:user)

    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button "Log in"
    #print page.html
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_css('div#flash_notice')
    expect(page).to have_css('div.alert.alert-success')
    
  end

  scenario 'unknown usrs get an error' do
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: "user.email"
    fill_in 'Password', with: "password1"
    click_button "Log in"

    expect(page).to have_content("Invalid email or password")
  end
end

