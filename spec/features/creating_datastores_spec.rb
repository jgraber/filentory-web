require 'spec_helper'

feature 'Creating Datastores' do
	scenario "can create a datastore" do
		visit '/'
		click_link 'New Datastore'
		fill_in 'Name', with: 'DVD 1'
		fill_in 'Mediatype', with: 'DVD'
		click_button 'Create Datastore'
		expect(page).to have_content('Datastore has been created.')
	end

end
