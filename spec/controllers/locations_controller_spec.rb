require 'spec_helper'

describe LocationsController do
  let!(:user){ FactoryGirl.create(:user)}
  
  before do
    sign_in user
  end
end
