class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@statistics = Datafile.count
  end
end