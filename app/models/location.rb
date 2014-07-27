class Location < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :datastore, :counter_cache => true
  belongs_to :datafile, :counter_cache => true

  attr_accessor :checksum, :size
  
  def path_name
    "#{path}/#{name}"
  end
end
