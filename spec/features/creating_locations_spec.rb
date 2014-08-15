require 'spec_helper'

feature 'Creating Location' do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    FactoryGirl.create(:datastore, name: "DVD 2")

    visit '/'
    click_link "DVD 2"
    click_link "New Location"
  end

  scenario "can create a location in a datastore" do
    fill_in 'Path', with: 'files'
    fill_in 'Name', with: 'base.txt'
    click_button 'Create Location'
    expect(page).to have_content('Location has been created.')

    expect(page).to have_content("files / base.txt")
  end
  
  scenario "can not create a location without a name" do
    click_button 'Create Location'
    expect(page).to have_content("Location has not been created.")
    expect(page).to have_content("Name can't be blank")
  end


  scenario "tracks location number" do
    
    10.times do |i|
      fill_in 'Path', with: 'files'
      fill_in 'Name', with: "base_#{i}.txt"
      click_button 'Create Location'
      click_link 'Show Datastore'
      click_link 'New Location'
    end

    visit '/'

    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(5)", text: '10')
  end

  scenario "can pint to an existing datafile without modifiing it" do
    visit '/datafiles'
    click_link 'New File'
    fill_in 'Name', with: 'connected.txt'
    fill_in 'Checksum', with: 'THIS_IS_A_HASH'
    click_button 'Create Datafile'

    visit '/'
    click_link "DVD 2"
    click_link "New Location"

    fill_in 'Path', with: 'other'
    fill_in 'Name', with: 'pointsTo.txt'
    fill_in 'Checksum', with: 'THIS_IS_A_HASH'
    fill_in 'Size', with: 100000

    click_button 'Create Location'
    expect(page).to have_content('Location has been created.')

    visit '/datafiles'
    #print page.html
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(3)", text: '') # size
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(5)", text: '1') # #locations 
  end

  scenario "can pint to an existing datafile without modifiing it" do
    fill_in 'Path', with: 'other'
    fill_in 'Name', with: 'pointsTo.txt'
    fill_in 'Checksum', with: 'THIS_IS_NOT_A_REAL_HASH'
    fill_in 'Size', with: 100000

    click_button 'Create Location'
    expect(page).to have_content('Location has been created.')

    visit '/datafiles'
    #print page.html
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(3)", text: '100000') # size
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(5)", text: '1') # #locations 
  end

  scenario "can update datafile it points to" do
    fill_in 'Path', with: 'other'
    fill_in 'Name', with: 'edit.txt'
    
    click_button 'Create Location'
    expect(page).to have_content('Location has been created.')

    click_link 'Edit Location'
    fill_in 'Checksum', with: 'HASH_AFTER_UPDATE'
    click_button 'Update Location'

    visit '/datafiles'
    #print page.html
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(4)", text: 'HASH_AFTER_UPDATE') # #locations 
    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(5)", text: '1') # #locations 
  end
end
