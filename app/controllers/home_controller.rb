class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@statistics = Statistics.new
  	@statistics.count = Datafile.count
  end
end