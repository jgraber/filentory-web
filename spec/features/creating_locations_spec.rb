require 'spec_helper'

feature 'Creating Location' do
	before do
		FactoryGirl.create(:datastore, name: "DVD 2")

		visit '/'
		click_link "DVD 2"
		click_link "New Location"
	end

	scenario "can create a location in a datastore" do
		fill_in 'Path', with: 'files/'
		fill_in 'Name', with: 'base.txt'
		click_button 'Create Location'
		expect(page).to have_content('Location has been created.')

		expect(page).to have_content("files/base.txt")
	end
	
	scenario "can not create a location without a name" do
		click_button 'Create Location'
		expect(page).to have_content("Location has not been created.")
		expect(page).to have_content("Name can't be blank")
	end

end
