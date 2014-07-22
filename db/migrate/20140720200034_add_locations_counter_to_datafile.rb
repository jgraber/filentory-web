class AddLocationsCounterToDatafile < ActiveRecord::Migration
  def up
    add_column :datafiles, :locations_count, :integer, :default => 0

    Datafile.reset_column_information
    Datafile.all.each do |d|
      Datafile.update_counters d.id, :locations_count => d.locations.length
    end
  end

  def down
    remove_column :datafiles, :locations_count
  end
end
