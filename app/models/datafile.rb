class Datafile < ActiveRecord::Base
	validates :name, presence: true
end
