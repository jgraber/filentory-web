require 'spec_helper'

feature "Editing Users" do
  let!(:user){ FactoryBot.create(:user, authentication_token: "abcdefghi123456")}

  before do
    sign_in_as!(user)
    visit "/"
    click_link "Edit account"
  end


  scenario "Can access their API key" do
    expect(page).to have_content("Your API Key")
    expect(page).to have_content(user.authentication_token)
  end
end