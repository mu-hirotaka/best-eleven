class CreateFormations < ActiveRecord::Migration
  def change
    create_table :formations, :id => false do |t|
      t.column :id, "int(11) PRIMARY KEY"
      t.string :type_name, :null => false
      t.string :title, :null => false
      t.string :css_title, :null => false
      t.text :image_position, :null => false
      t.text :text_position, :null => false
      t.timestamps
    end
  end
end
