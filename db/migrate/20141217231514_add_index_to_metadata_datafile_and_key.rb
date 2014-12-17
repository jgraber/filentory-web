class AddIndexToMetadataDatafileAndKey < ActiveRecord::Migration
  def change
  	add_index :metadata, [:datafile_id, :key]
  end
end
