require 'spec_helper'

feature "Deleting datafiles" do
  let!(:user){ FactoryBot.create(:user)}

  before do
    sign_in_as!(user)
  end

  scenario "Deleting a datafile" do
    FactoryBot.create(:datafile, name: "base.txt")
    
    visit "/datafiles"
    click_link "base.txt"
    click_link "Delete Datafile"
    
    expect(page).to have_content("Datafile has been destroyed.")
    
    visit "/datafiles"
    
    expect(page).to have_no_content("base.txt")
  end
end
