class Metadata < ActiveRecord::Base
	validates :key, :value, presence: true
  belongs_to :datafile

  def to_s
  	"#{key}: #{value}"
  end
end
