class CreateDatastores < ActiveRecord::Migration
  def change
    create_table :datastores do |t|
      t.string :name
      t.string :mediatype

      t.timestamps
    end
  end
end
