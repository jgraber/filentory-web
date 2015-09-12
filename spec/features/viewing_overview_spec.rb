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

  scenario "The size of all files is shown" do
    size = 0*10 + 1*10 + 2*10 + 3*10 + 4*10 +5*10 + 6*10 + 7*10 + 8*10 + 9*10
    expect(page).to have_content("Total size: #{size}")
  end

  scenario "The minimum size of all files is shown" do
    minimumSize = 0*10
    expect(page).to have_content("Minimum size: #{minimumSize}")
  end

  scenario "The maximum size of all files is shown" do
    maximumSize = 9*10
    expect(page).to have_content("Maximum size: #{maximumSize}")
  end
end
