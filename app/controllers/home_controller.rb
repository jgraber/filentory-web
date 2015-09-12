class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@statistics = Statistics.new
  	@statistics.count = Datafile.count  	
  	@statistics.total = Datafile.sum(:size)
  	@statistics.min = Datafile.minimum(:size)
  	@statistics.max = Datafile.maximum(:size)
  end
end