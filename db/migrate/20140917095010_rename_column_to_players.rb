class RenameColumnToPlayers < ActiveRecord::Migration
  def change
    rename_column :players, :valid, :valid_st
  end
end
