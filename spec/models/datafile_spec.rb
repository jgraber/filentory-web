require 'spec_helper'

describe Datafile do
  it "tracks number of locations" do
    datafile = Datafile.new(name: "locnumber")

    location = datafile.locations.build
    location.path = "/"
    location.name = "file.txt"

    datafile.save!

    file = Datafile.where(id: datafile.id).first
    file.locations_count.should == 1
  end
end