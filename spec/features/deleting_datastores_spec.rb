require 'spec_helper'

feature "Deleting datastores" do
	scenario "Deleting a datastore" do
		FactoryGirl.create(:datastore, name: "DVD 1")
		
		visit "/"
		click_link "DVD 1"
		click_link "Delete Datastore"
		
		expect(page).to have_content("Datastore has been destroyed.")
		
		visit "/"
		
		expect(page).to have_no_content("DVD 1")
end
end
