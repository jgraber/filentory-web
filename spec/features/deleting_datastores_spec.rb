require 'spec_helper'

feature "Deleting datastores" do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:datastore) {FactoryGirl.create(:datastore, name: "DVD 1")}

  before do
    sign_in_as!(user)
    visit '/'
  end

  scenario "Deleting a datastore" do
    
    
    click_link "DVD 1"
    click_link "Delete Datastore"
    
    expect(page).to have_content("Datastore has been destroyed.")
    
    visit "/"
    
    expect(page).to have_no_content("DVD 1")
  end
end
