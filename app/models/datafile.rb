class Datafile < ApplicationRecord
  paginates_per 15
  validates :name, presence: true

  has_many :metadata
  has_many :locations
end
