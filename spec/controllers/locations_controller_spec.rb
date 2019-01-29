require 'spec_helper'

describe LocationsController, :type => :controller do
  let!(:user){ FactoryBot.create(:user)}
  
  before do
    sign_in user
  end
end
