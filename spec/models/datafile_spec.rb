require 'spec_helper'

describe Datafile do
  it "tracks number of locations" do
    datafile = Datafile.new(name: "locnumber")

    location = datafile.locations.build
    location.path = "/"
    location.name = "file.txt"

    datafile.save!

    file = Datafile.where(id: datafile.id).first
    expect(file.locations_count).to eq 1
  end
end