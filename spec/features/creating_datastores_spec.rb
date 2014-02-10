require 'spec_helper'

feature 'Creating Datastores' do
	scenario "can create a datastore" do
		visit '/'
		click_link 'New Datastore'
		fill_in 'Name', with: 'DVD 1'
		fill_in 'Mediatype', with: 'DVD'
		click_button 'Create Datastore'
		expect(page).to have_content('Datastore has been created.')

		title = "DVD 1 - Datastores - Filentory"
		#print page.html
		expect(page).to have_title(title)

	end

	#scenario "sets the name as the page title" do
	#	datastore = Datastore.where(name: "DVD 1").first
	#	expect(page.current_url).to eql(datastore_url(datastore))
	#	
	#end

end
