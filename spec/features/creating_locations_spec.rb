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
    fill_in 'Path', with: 'files/'
    fill_in 'Name', with: 'base.txt'
    click_button 'Create Location'
    expect(page).to have_content('Location has been created.')

    expect(page).to have_content("files/base.txt")
  end
  
  scenario "can not create a location without a name" do
    click_button 'Create Location'
    expect(page).to have_content("Location has not been created.")
    expect(page).to have_content("Name can't be blank")
  end


  scenario "tracks location number" do
    
    10.times do |i|
      fill_in 'Path', with: 'files/'
      fill_in 'Name', with: "base_#{i}.txt"
      click_button 'Create Location'
      click_link 'Show Datastore'
      click_link 'New Location'
    end

    visit '/'

    page.should have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(5)", text: '10')
  end
end
