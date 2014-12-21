class ChangeSizeToBigint < ActiveRecord::Migration
  def self.up
  	change_column :datafiles, :size, :bigint
  end

  def self.down
  	change_column :datafiles, :size, :int
  end 
end
