require 'spec_helper'

feature 'Creating Metadata' do
  let!(:user){ FactoryBot.create(:user)}

  before do
    sign_in_as!(user)
    FactoryBot.create(:datafile, name: "fileA.txt")

    visit '/datafiles'
    click_link "fileA.txt"
    click_link "Add Metadata"
  end

  scenario "can create metadata for datafile" do
    fill_in 'Key', with: 'exif.artist'
    fill_in 'Value', with: 'Johnny Graber'
    click_button 'Create Metadata'
    expect(page).to have_content('Metadata has been created.')

    expect(page).to have_content("exif.artist")
    expect(page).to have_content("Johnny Graber")
  end
  
  scenario "can not create metadata without a key or value" do
    click_button 'Create Metadata'
    expect(page).to have_content("Metadata has not been created.")
    expect(page).to have_content("Key can't be blank")
    expect(page).to have_content("Value can't be blank")
  end

end
