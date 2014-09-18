class RenameColumnToPlayer < ActiveRecord::Migration
  def change
    rename_column :players, :type, :type_id
  end
end
