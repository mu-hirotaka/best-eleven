class CreateUserBoketeImages < ActiveRecord::Migration
  def change
    create_table :user_bokete_images do |t|
      t.integer :base_image_id, null: false
      t.string :comment, null: false
      t.integer :image_id, null:false
      t.timestamps
    end
  end
end
