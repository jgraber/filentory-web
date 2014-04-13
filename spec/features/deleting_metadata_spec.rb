require 'spec_helper'

feature "Deleting Metadata" do
  let!(:user){ FactoryGirl.create(:user)}
  let!(:datafile) {FactoryGirl.create(:datafile)}
  let!(:metadata) {FactoryGirl.create(:metadata, datafile: datafile)}

  before do
    sign_in_as!(user)
    visit "/datafiles"
    click_link datafile.name
    click_link metadata.key
  end


  scenario "Deleting metadata" do
    click_link "Delete Metadata"

    expect(page).to have_content("Metadata has been deleted.")
    expect(page.current_url).to eq (datafile_url(datafile))
  end

end
