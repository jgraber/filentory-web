class Datastore < ApplicationRecord
  paginates_per 25

  validates :name, presence: true

  has_many :locations, dependent: :delete_all
end
