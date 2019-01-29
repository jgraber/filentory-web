require 'spec_helper'

describe DatafilesController, :type => :controller do
  let!(:user){ FactoryBot.create(:user)}
  
  before do
    sign_in user
  end

  it "displays an error for a missing datafile" do
    get :show, params: {id: "not-here"}   
    expect(response).to redirect_to(datafiles_path)
    message = "The datafile you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

end
