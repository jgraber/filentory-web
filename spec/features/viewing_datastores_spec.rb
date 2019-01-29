require 'spec_helper'

feature "Viewing datastores" do
  let!(:user){ FactoryBot.create(:user)}

  before do
    sign_in_as!(user)
  end

  scenario "Listing all datastores" do
    datastore = FactoryBot.create(:datastore, name: "DVD 1")
    
    visit '/'
    click_link "Datastores"
    click_link 'DVD 1'
    expect(page.current_url).to eql(datastore_url(datastore))
  end

  scenario "Show datastores as table" do
    ds1 = FactoryBot.create(:datastore, name: "Disk 1b", mediatype: "DVD")    
    ds2 = FactoryBot.create(:datastore, name: "Disk 2", mediatype: "CD")

    visit '/'
    click_link "Datastores"
    expect(find('tr', text: ds1.name)).to have_content("DVD")
    expect(find('tr', text: ds2.id)).to have_content("CD")    
  end

  scenario "Paging is enabled" do
    (0..100).each do |i|
      FactoryBot.create(:datastore, name: "Disk #{i}", mediatype: "DVD")
    end

    visit '/'
    click_link "Datastores"
    
    expect(page).to have_content("Next")
    expect(page).to have_content("Disk 100")
    expect(page).not_to have_content("Disk 0")
    expect(page).not_to have_content("Prev")

    click_link 'Last'
    expect(page).to have_content("Disk 0")
    expect(page).not_to have_content("Disk 100")
    expect(page).to have_content("Prev")
  end

  scenario "Newest datastore is showed first" do
    (1..50).each do |i|
      FactoryBot.create(:datastore, name: "Disk #{i}", mediatype: "DVD")
    end
    
    visit '/'
    click_link "Datastores"
    
    expect(page).to have_content("Disk 50")
    expect(page).not_to have_content("Disk 1")
  end
end
