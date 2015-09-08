require 'spec_helper'

feature 'Creating Datastores' do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Datastores"
  end

  scenario "can create a datastore" do
    click_link 'New Datastore'
    fill_in 'Name', with: 'DVD 1'
    fill_in 'Mediatype', with: 'DVD'
    click_button 'Create Datastore'
    expect(page).to have_content('Datastore has been created.')

    title = "DVD 1 - Datastores - Filentory"
    expect(page).to have_title(title)
    #print page.html # for debug 
  end
  
  scenario "can not create a datastore without a name" do
    click_link 'New Datastore'
    click_button 'Create Datastore'
    expect(page).to have_content("Datastore has not been created.")
    expect(page).to have_content("Name can't be blank")
  end

end
