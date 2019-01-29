require 'spec_helper'

feature "Viewing metadata" do
  let!(:user){ FactoryBot.create(:user)}

  before do
    sign_in_as!(user)
    fileA = FactoryBot.create(:datafile, name: "fileA.txt")
    FactoryBot.create(:metadata, 
        datafile: fileA,
        key: "author", 
        value: "Johnny Graber")

    fileB = FactoryBot.create(:datafile, name: "fileB.txt")
    FactoryBot.create(:metadata, datafile: fileB, key: "AA", value: "PDF")
    FactoryBot.create(:metadata, datafile: fileB, key: "ZZ", value: "125x256")

    visit '/datafiles'
  end


  scenario "Viewing metadata for a given datafile" do
    click_link 'fileA.txt'

    expect(page).to have_content("author: Johnny Graber")
    expect(page).to_not have_content("AA")

    click_link 'author: Johnny Graber'
    within("#metadata") do
      expect(page).to have_content("author")
    end
  end

  scenario "Metadata is alphabeticaly sorted by key" do
    click_link 'fileB.txt'
    
    #print page.html
    expect(page).to have_selector("table#metadata tr:nth-child(1) td:nth-child(2)", text: "AA: PDF")
    expect(page).to have_selector("table#metadata tr:nth-child(2) td:nth-child(2)", text: "ZZ: 125x256")
  end
end
