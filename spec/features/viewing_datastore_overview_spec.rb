require 'spec_helper'

feature "Viewing the Datastore overview" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    3.times do |i|
      FactoryGirl.create(:datastore, mediatype: "CD")
    end
    10.times do |i|
      FactoryGirl.create(:datastore, mediatype: "DVD")
    end
    6.times do |i|
      FactoryGirl.create(:datastore, mediatype: "HDD")
    end

    sign_in_as!(user)
    visit '/'
  end


  scenario "The overview contains a part for datastores" do
    expect(page).to have_content("Types of Datastores")
  end

  scenario "The number of mediatypes is in descending order" do
    have_selector("div.datastoretypes") do |content|
      expect(content).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(1)", text: 'DVD:') # first row, first column
      expect(content).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(2)", text: '10') # first row, second column
    
      expect(content).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(1)", text: 'HDD:') # second row, first column
      expect(content).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(2)", text: '6') # second row, second column
    
      expect(content).to have_selector("table tbody tr:nth-of-type(3) td:nth-of-type(1)", text: 'CD:') # third row, first column
      expect(content).to have_selector("table tbody tr:nth-of-type(3) td:nth-of-type(2)", text: 3) # third row, second column
    end
  end
end
