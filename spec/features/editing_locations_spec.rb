require 'spec_helper'

feature "Editing Locations" do
	let!(:datastore) {FactoryGirl.create(:datastore)}
	let!(:location) {FactoryGirl.create(:location, datastore: datastore)}

	before do
		visit "/"
		click_link datastore.name
		click_link location.path_name
		click_link "Edit Location"
	end


	scenario "Updating a location" do
		fill_in "Name", with: "movie.mov"
		click_button "Update Location"

		expect(page).to have_content("Location has been updated.")
	end

	scenario "Updating a location with invalid attributes is bad" do
		fill_in "Name", with: ""
		click_button "Update Location"
		
		expect(page).to have_content("Location has not been updated.")
	end

end
