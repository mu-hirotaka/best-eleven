class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :image_id, :null => false
      t.string :comment, :null => false
      t.timestamps
    end

    add_index :user_comments, [:image_id]
  end
end
