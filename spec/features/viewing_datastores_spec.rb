require 'spec_helper'

feature "Viewing datastores" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
  end

  scenario "Listing all datastores" do
    datastore = FactoryGirl.create(:datastore, name: "DVD 1")
    
    visit '/'
    click_link 'DVD 1'
    expect(page.current_url).to eql(datastore_url(datastore))
  end
end
