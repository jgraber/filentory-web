require 'spec_helper'

feature "Viewing datafiles" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    @datafile = FactoryGirl.create(:datafile, name: "base.txt")
    visit '/datafiles'
  end
  
  scenario "Listing all datafiles" do
    click_link 'base.txt'
    expect(page.current_url).to eql(datafile_url(@datafile))
  end

  scenario "Viewing locations for a given datafile" do
    dvd1 = FactoryGirl.create(:datastore, name: "DVD 1")
    FactoryGirl.create(:location, 
        datastore: dvd1, 
        path: "folder", 
        name: "fileA.txt",
        last_modified: "2014-02-16 12:00:00",
        datafile: @datafile)

    click_link 'base.txt'
    expect(page).to have_content("folder/fileA.txt")
    expect(page).to have_content("DVD 1")
  end

  scenario "Show datafiles as table" do
    df1 = FactoryGirl.create(:datafile, name: "File 1b", checksum: "12556356")    
    df2 = FactoryGirl.create(:datafile, name: "File 2", checksum: "4146541315", size: 1256)

    visit '/datafiles'
    find('tr', text: df1.name).should have_content("File 1b")
    find('tr', text: df2.checksum).should have_content("4146541315")    
    find('tr', text: df2.size).should have_content("1256")  
  end
end
