require 'spec_helper'

feature "Viewing the overview" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
    visit '/'
  end


  scenario "The overview welcomes the user" do
    expect(page).to have_content("Welcome to Filentory")
  end
end
