require 'spec_helper'

feature "Viewing datafiles" do
	let!(:user){ FactoryGirl.create(:user)}

	before do
		sign_in_as!(user)
		@datafile = FactoryGirl.create(:datafile, name: "base.txt")
		visit '/datafiles'
	end
	
	scenario "Listing all datafiles" do
		click_link 'base.txt'
		expect(page.current_url).to eql(datafile_url(@datafile))
	end

	scenario "Viewing locations for a given datafile" do
		dvd1 = FactoryGirl.create(:datastore, name: "DVD 1")
		FactoryGirl.create(:location, 
				datastore: dvd1, 
				path: "/folder/", 
				name: "fileA.txt",
				last_modified: "2014-02-16 12:00:00",
				datafile: @datafile)

		click_link 'base.txt'
		expect(page).to have_content("/folder/fileA.txt")
		expect(page).to have_content("DVD 1")
	end
end
