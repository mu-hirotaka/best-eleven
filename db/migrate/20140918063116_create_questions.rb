class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, :id => false do |t|
      t.column :id, "int(11) PRIMARY KEY"
      t.string :title, :null => false
      t.string :description, :null => false
      t.text :valid_player_type_ids, :null => false
      t.timestamps
    end
  end
end
