require 'spec_helper'

feature "Viewing locations" do
	let!(:user){ FactoryGirl.create(:user)}

	before do
		sign_in_as!(user)
		fileA = FactoryGirl.create(:datafile, name: "fileA.txt")
		FactoryGirl.create(:metadata, 
				datafile: fileA,
				key: "author", 
				value: "Johnny Graber")

		fileB = FactoryGirl.create(:datafile, name: "fileB.txt")
		FactoryGirl.create(:metadata, datafile: fileB, key: "AA", value: "VALLL")

		visit '/datafiles'
	end


	scenario "Viewing metadata for a given datafile" do
		click_link 'fileA.txt'

		expect(page).to have_content("author: Johnny Graber")
		expect(page).to_not have_content("AA")

		click_link 'author: Johnny Graber'
		within("#metadata") do
			expect(page).to have_content("author")
		end
	end
end
