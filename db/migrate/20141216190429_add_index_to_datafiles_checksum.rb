class AddIndexToDatafilesChecksum < ActiveRecord::Migration
  def change
    add_index :datafiles, :checksum
  end
end
