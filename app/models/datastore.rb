class Datastore < ActiveRecord::Base
	validates :name, presence: true

	has_many :locations, dependent: :delete_all
end
