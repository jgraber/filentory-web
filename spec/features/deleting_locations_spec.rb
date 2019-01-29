require 'spec_helper'

feature "Deleting Locations" do
  let!(:user){ FactoryBot.create(:user)}
  let!(:datastore) {FactoryBot.create(:datastore)}
  let!(:location) {FactoryBot.create(:location, datastore: datastore)}

  before do
    sign_in_as!(user)
    visit "/"
    click_link "Datastores"
    click_link datastore.name
    click_link location.name
  end


  scenario "Deleting a location" do
    click_link "Delete Location"

    expect(page).to have_content("Location has been deleted.")
    expect(page.current_url).to eq (datastore_url(datastore))
  end

end
