require 'spec_helper'

feature "Viewing the overview" do
  let!(:user){ FactoryGirl.create(:user)}

  before do
    10.times do |i|
      FactoryGirl.create(:datafile, name: "file#{i}.txt", size: i * 10)
    end

    sign_in_as!(user)
    visit '/'
  end


  scenario "The overview welcomes the user" do
    expect(page).to have_content("Welcome to Filentory")
  end

  scenario "The number of files is shown" do
    expect(page).to have_content("#Datafiles: 10")
  end
end
