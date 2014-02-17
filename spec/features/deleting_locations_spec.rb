require 'spec_helper'

feature "Deleting Locations" do
	let!(:user){ FactoryGirl.create(:user)}
	let!(:datastore) {FactoryGirl.create(:datastore)}
	let!(:location) {FactoryGirl.create(:location, datastore: datastore)}

	before do
		sign_in_as!(user)
		visit "/"
		click_link datastore.name
		click_link location.path_name
	end


	scenario "Deleting a location" do
		click_link "Delete Location"

		expect(page).to have_content("Location has been deleted.")
		expect(page.current_url).to eq (datastore_url(datastore))
	end

end
