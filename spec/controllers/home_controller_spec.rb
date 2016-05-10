require 'spec_helper'

describe HomeController, :type => :controller do

  let!(:user){ FactoryGirl.create(:user)}

  it "redirect to login when not authenticated" do
    get :index, id: "not-here"   
    expect(response).to redirect_to("/users/sign_in")
    message = "You need to sign in or sign up before continuing."
    expect(flash[:alert]).to eql(message)
  end

  
end