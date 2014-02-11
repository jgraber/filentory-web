class Datastore < ActiveRecord::Base
	validates :name, presence: true
end
