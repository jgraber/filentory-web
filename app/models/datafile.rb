class Datafile < ActiveRecord::Base
	validates :name, presence: true

	has_many :metadata
	has_many :locations
end
