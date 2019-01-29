class Metadata < ApplicationRecord
  validates :key, :value, presence: true
  belongs_to :datafile

  def to_s
    "#{key}: #{value}"
  end
end
