class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@statistics = collect_datafile_statistics

  	@datastore_types = Datastore.group(:mediatype).count.sort_by {|k, v| v}.reverse.to_h
  end

  private
  def collect_datafile_statistics
  	statistics = Statistics.new
  	statistics.count = Datafile.count  	
  	statistics.total = Datafile.sum(:size)
  	statistics.min = Datafile.minimum(:size)
  	statistics.max = Datafile.maximum(:size)
  	statistics.average = Datafile.average(:size)
  	
  	statistics
  end
end