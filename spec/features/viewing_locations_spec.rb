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
    click_link "Datastores"
  end


  scenario "Viewing locations for a given datastrore" do
    click_link 'DVD 1'

    expect(find('tr', text: "folder")).to have_content("fileA.txt")
    expect(page).to_not have_content("fileB.txt")

    click_link 'fileA.txt'
    within("#location h2") do
      expect(page).to have_content("fileA.txt")
    end

    expect(page).to have_content("2014-02-16 12:00:00")   
  end

  scenario "Location details show correct path" do
    click_link 'DVD 1'

    click_link 'fileA.txt'

    within("#location h2") do
      expect(page).to have_content("folder / fileA.txt")
    end
  end


  scenario "Detail page of datastore uses paging for locations" do
    ds = FactoryGirl.create(:datastore, name: "Paging", mediatype: "DVD") 
    (1..50).each do |i|
      number = "%03d" % i 
      FactoryGirl.create(:location, datastore: ds, path: "/", name: "file_#{number}.txt")
    end
    
    visit '/'
    click_link "Datastores"
    click_link 'Paging'

    expect(page).to have_content("Next")
    expect(page).to have_content("file_001.txt")
    expect(page).not_to have_content("file_050.txt")
    expect(page).not_to have_content("Prev")

    click_link 'Last'

    #print page.html
    expect(page).to have_content("file_050.txt")
    expect(page).not_to have_content("file_001.txt")
    expect(page).to have_content("Prev")
  end
end
