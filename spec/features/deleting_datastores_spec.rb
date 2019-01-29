require 'spec_helper'

feature "Deleting datastores" do
  let!(:user) {FactoryBot.create(:user)}
  let!(:datastore) {FactoryBot.create(:datastore, name: "DVD 1")}

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Datastores"
  end

  scenario "Deleting a datastore" do
    
    
    click_link "DVD 1"
    click_link "Delete Datastore"
    
    expect(page).to have_content("Datastore has been destroyed.")
    
    visit "/"
    
    expect(page).to have_no_content("DVD 1")
  end
end
