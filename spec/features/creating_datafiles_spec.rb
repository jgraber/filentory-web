require 'spec_helper'

feature 'Creating Files' do
	scenario "can create a file" do
		visit '/'
		click_link 'New File'
		fill_in 'Name', with: 'base.txt'
		fill_in 'Size', with: 1024
		click_button 'Create Datafile'
		expect(page).to have_content('Datafile has been created.')

		title = "base.txt - File - Filentory"
		expect(page).to have_title(title)
		#print page.html # for debug 
	end
	
	scenario "can not create a file without a name" do
		visit '/'
		click_link 'New File'
		click_button 'Create Datafile'
		expect(page).to have_content("Datafile has not been created.")
		expect(page).to have_content("Name can't be blank")
	end

end
