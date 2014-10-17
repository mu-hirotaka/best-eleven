class RenameColumnToMaintenance < ActiveRecord::Migration
  def change
    rename_column :maintenances, :valid, :valid_st
  end
end
