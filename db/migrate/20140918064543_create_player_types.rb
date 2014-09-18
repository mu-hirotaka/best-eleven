class CreatePlayerTypes < ActiveRecord::Migration
  def change
    create_table :player_types, :id => false do |t|
      t.column :id, "int(11) PRIMARY KEY"
      t.string :title, :null => false
      t.timestamps
    end
  end
end
