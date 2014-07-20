require 'spec_helper'

describe Datastore do
  it "tracks number of locations" do
    datastore = Datastore.new(name: "locnumber")

    location = datastore.locations.build
    location.path = "/"
    location.name = "file.txt"

    datastore.save!

    store = Datastore.where(id: datastore.id).first
    store.locations_count.should == 1
  end
end