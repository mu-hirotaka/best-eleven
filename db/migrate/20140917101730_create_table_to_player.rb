class CreateTableToPlayer < ActiveRecord::Migration
  def change
    create_table :players, :id => false do |t|
      t.integer :id, :options => 'PRIMARY KEY'
      t.integer :type_id, :null => false
      t.string :full_name, :null => false
      t.string :short_name, :null => false
      t.integer :valid_st, :null => false
      t.timestamps
    end
  end
end
