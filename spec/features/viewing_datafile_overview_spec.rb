require 'spec_helper'

feature "Viewing the Datafile overview" do
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
    expect(page).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(1)", text: '#Datafiles:') # first row, first column
    expect(page).to have_selector("table tbody tr:nth-of-type(1) td:nth-of-type(2)", text: '10') # first row, second column
  end

  scenario "The size of all files is shown" do
    size = 0*10 + 1*10 + 2*10 + 3*10 + 4*10 +5*10 + 6*10 + 7*10 + 8*10 + 9*10
    expect(page).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(1)", text: 'Total size:') # second row, first column
    expect(page).to have_selector("table tbody tr:nth-of-type(2) td:nth-of-type(2)", text: size) # second row, second column
  end

  scenario "The minimum size of all files is shown" do
    minimumSize = 0*10
    expect(page).to have_selector("table tbody tr:nth-of-type(3) td:nth-of-type(1)", text: 'Minimum size:') # third row, first column
    expect(page).to have_selector("table tbody tr:nth-of-type(3) td:nth-of-type(2)", text: minimumSize) # third row, second column
  end

  scenario "The maximum size of all files is shown" do
    maximumSize = 9*10
    expect(page).to have_selector("table tbody tr:nth-of-type(4) td:nth-of-type(1)", text: 'Maximum size:') # forth row, first column
    expect(page).to have_selector("table tbody tr:nth-of-type(4) td:nth-of-type(2)", text: maximumSize) # forth row, second column
  end

  scenario "The average size of all files is shown" do
    averageSize = (0*10 + 1*10 + 2*10 + 3*10 + 4*10 +5*10 + 6*10 + 7*10 + 8*10 + 9*10) / 10
    expect(page).to have_selector("table tbody tr:nth-of-type(5) td:nth-of-type(1)", text: 'Average size:') # fifth row, first column
    expect(page).to have_selector("table tbody tr:nth-of-type(5) td:nth-of-type(2)", text: averageSize) # fifth row, second column
  end
end
