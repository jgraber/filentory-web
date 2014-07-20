require 'spec_helper'

feature "Navigation Filentory" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    sign_in_as!(user)
  end

  scenario "Main page shows datastores" do
    visit "/"

    expect(page).to have_title "Datastores - Filentory"
  end

  scenario "Main page has link to datafiles" do
    visit "/"
    click_link "Datafiles"

    expect(page).to have_title "Datafiles - Filentory"
  end

  scenario "Datafiles has a link to datastores" do
    visit "/datafiles"
    click_link "Datastores"

    expect(page).to have_title "Datastores - Filentory"
  end

end