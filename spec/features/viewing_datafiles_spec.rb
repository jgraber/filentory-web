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
    df2 = FactoryGirl.create(:datafile, name: "File 2", checksum: "4146541315", size: 12560)

    visit '/datafiles'
    expect(page).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(2)", text: 'File 2')
    expect(page).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(3)", text: '12.3 KB')
    expect(page).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(4)", text: '4146541315')

    expect(page).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(2)", text: 'File 1b')
    expect(page).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(3)", text: '1 Byte')
    expect(page).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(4)", text: '12556356')
  end

  scenario "Paging is enabled" do
    (0..100).each do |i|
      FactoryGirl.create(:datafile, name: "File #{i}", checksum: "ABCD #{i}", size: 658)
    end

    visit '/datafiles'
    expect(page).to have_content("Next")
    expect(page).to have_content("File 100")
    expect(page).not_to have_content("File 0")
    expect(page).not_to have_content("Prev")

    click_link 'Last'
    expect(page).to have_content("File 0")
    expect(page).not_to have_content("File 100")
    expect(page).to have_content("Prev")
  end
end
