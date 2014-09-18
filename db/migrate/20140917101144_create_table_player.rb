class CreateTablePlayer < ActiveRecord::Migration
  def change
    create_table :players, :id => false do |t|
      t.integer :id, :null => false
      t.integer :type, :null => false
      t.string :full_name, :null => false
      t.string :short_name, :null => false
      t.integer :valid, :null => false
      t.timestamps
    end
  end
end
