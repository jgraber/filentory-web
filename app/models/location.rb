class Location < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :datastore, :counter_cache => true
  belongs_to :datafile

  def path_name
    "#{path}/#{name}"
  end
end
