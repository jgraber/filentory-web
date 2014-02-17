require 'spec_helper'

feature 'Signing up' do
	before do
		visit '/'
		
		first(:link, 'Sign up').click
	end
	
	scenario 'Successful sign up' do
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"
	
		expect(page).to have_content("You have signed up successfully.")
	end

	scenario 'wrong passwort confirmation fails sign up' do
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password2"
		click_button "Sign up"
	
		expect(page).to have_content("Password confirmation doesn't match Password")
	end
end
