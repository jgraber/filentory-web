class Location < ActiveRecord::Base
	validates :name, presence: true
	
  belongs_to :datastore
  belongs_to :datafile
end
