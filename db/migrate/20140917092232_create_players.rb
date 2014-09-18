class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :type, :null => false
      t.string :full_name, :null => false
      t.string :short_name, :null => false
      t.integer :valid, :null => false
      t.timestamps
    end
  end
end
