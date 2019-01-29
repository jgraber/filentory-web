require 'spec_helper'

feature "Editing Datastores" do
  let!(:user){ FactoryBot.create(:user)}

  before do
    FactoryBot.create(:datastore, name: "DVD 1")
    
    sign_in_as!(user)
    visit "/"
    click_link "Datastores"
    click_link "DVD 1"
    click_link "Edit Datastore"
  end


  scenario "Updating a datastore" do
    fill_in "Name", with: "DVD 2"
    click_button "Update Datastore"

    expect(page).to have_content("Datastore has been updated.")
  end

  scenario "Updating a datastore with invalid attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Datastore"
    
    expect(page).to have_content("Datastore has not been updated.")
  end

end
