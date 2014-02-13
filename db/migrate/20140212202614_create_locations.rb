class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :path
      t.string :name
      t.datetime :last_modified
      t.references :datastore, index: true
      t.references :datafile, index: true

      t.timestamps
    end
  end
end
