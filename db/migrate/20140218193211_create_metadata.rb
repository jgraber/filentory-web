class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :key
      t.string :value
      t.references :datafile, index: true

      t.timestamps
    end
  end
end
