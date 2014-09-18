class RenameToPlayer < ActiveRecord::Migration
  def change
    rename_column :players, :type, :type_id
    rename_column :players, :valid, :valid_st
  end
end
