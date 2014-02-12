require 'spec_helper'

describe DatastoresController do
	it "displays an error for a missing datastore" do
		get :show, id: "not-here"		
		expect(response).to redirect_to(datastores_path)
		message = "The datastore you were looking for could not be found."
		expect(flash[:alert]).to eql(message)
	end

end