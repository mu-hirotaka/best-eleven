class CreateUserPostImages < ActiveRecord::Migration
  def change
    create_table :user_post_images do |t|
      t.integer :question_id, :null => false
      t.string :image_name, :null => false
      t.string :comment
      t.timestamps
    end
  end
end
