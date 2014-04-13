require 'spec_helper'

feature "Editing Metadata" do
  let!(:user){ FactoryGirl.create(:user)}
  let!(:datafile) {FactoryGirl.create(:datafile)}
  let!(:metadata) {FactoryGirl.create(:metadata, datafile: datafile)}

  before do
    sign_in_as!(user)
    visit "/datafiles"
    click_link datafile.name
    click_link metadata.to_s
    click_link "Edit Metadata"
  end


  scenario "Updating a metadata" do
    fill_in "Key", with: "creator"
    click_button "Update Metadata"

    expect(page).to have_content("Metadata has been updated.")
  end

  scenario "Updating a metadata with invalid attributes is bad" do
    fill_in "Key", with: ""
    click_button "Update Metadata"
    
    expect(page).to have_content("Metadata has not been updated.")
  end

end
