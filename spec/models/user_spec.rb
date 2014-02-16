require 'spec_helper'

describe User do
	describe "passwords" do
		it "needs a password and confirmation to save" do
			u = User.new(name: "Johnny", email: "JG@JGraber.ch")

			u.save
			expect(u).to_not be_valid

			u.password = "password"
			u.password_confirmation = ""
			u.save
			expect(u).to_not be_valid
			
			u.password_confirmation = "password"
			u.save
			expect(u).to be_valid
		end
			
		it "needs password and confirmation to match" do
			u = User.create(
				name: "Johnny",
				password: "gugushallo",
				password_confirmation: "gugus2",
				email: "JG@JGraber.ch")

			expect(u).to_not be_valid
		end
	end
end