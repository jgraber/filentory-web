class Location < ActiveRecord::Base
  paginates_per 15
  validates :name, presence: true
  
  belongs_to :datastore, :counter_cache => true
  belongs_to :datafile, :counter_cache => true

  attr_accessor :checksum, :size
  
  def path_name
    "#{path}/#{name}"
  end
end
