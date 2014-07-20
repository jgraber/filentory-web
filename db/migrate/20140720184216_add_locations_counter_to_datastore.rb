class AddLocationsCounterToDatastore < ActiveRecord::Migration
  def up
    add_column :datastores, :locations_count, :integer, :default => 0

    Datastore.reset_column_information
    Datastore.all.each do |d|
      Datastore.update_counters d.id, :locations_count => d.locations.length
    end
  end

  def down
    remove_column :datastores, :locations_count
  end
end
