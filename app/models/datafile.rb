class Datafile < ActiveRecord::Base
	validates :name, presence: true

	has_many :metadata
end
