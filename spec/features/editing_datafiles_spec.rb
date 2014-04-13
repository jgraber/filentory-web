require 'spec_helper'

feature "Editing Datafiles" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    FactoryGirl.create(:datafile, name: "base.txt")
    
    visit "/datafiles"
    click_link "base.txt"
    click_link "Edit Datafile"
  end


  scenario "Updating a datafile" do
    fill_in "Name", with: "otherfile.txt"
    click_button "Update Datafile"

    expect(page).to have_content("Datafile has been updated.")
  end

  scenario "Updating a datafile with invalid attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Datafile"
    
    expect(page).to have_content("Datafile has not been updated.")
  end

end
