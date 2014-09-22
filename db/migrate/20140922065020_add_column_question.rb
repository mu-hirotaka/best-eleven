class AddColumnQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :valid_st, :integer, :null => false
  end
end
