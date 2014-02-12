require 'spec_helper'

feature "Viewing datafiles" do
	scenario "Listing all datafiles" do
		datafile = FactoryGirl.create(:datafile, name: "base.txt")
		visit '/datafiles'
		click_link 'base.txt'
		expect(page.current_url).to eql(datafile_url(datafile))
	end
end
