require 'spec_helper'

describe Datastore do
  it "tracks number of locations" do
    datastore = Datastore.new(name: "locnumber")

    location = datastore.locations.build
    location.path = "/"
    location.name = "file.txt"

    datastore.save!

    store = Datastore.where(id: datastore.id).first
    expect(store.locations_count).to eq 1
  end
end