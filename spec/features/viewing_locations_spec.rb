require 'spec_helper'

feature "Viewing locations" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    dvd1 = FactoryGirl.create(:datastore, name: "DVD 1")
    FactoryGirl.create(:location, 
        datastore: dvd1, 
        path: "folder", 
        name: "fileA.txt",
        last_modified: "2014-02-16 12:00:00")

    dvd2 = FactoryGirl.create(:datastore, name: "DVD 2")
    FactoryGirl.create(:location, datastore: dvd2, path: "/", name: "fileb.txt")

    visit '/'
  end


  scenario "Viewing locations for a given datastrore" do
    click_link 'DVD 1'

    find('tr', text: "folder").should have_content("fileA.txt")
    expect(page).to_not have_content("fileB.txt")

    click_link 'fileA.txt'
    within("#location h2") do
      expect(page).to have_content("fileA.txt")
    end

    expect(page).to have_content("2014-02-16 12:00:00")   
  end
end
