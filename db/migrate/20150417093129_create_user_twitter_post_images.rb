class CreateUserTwitterPostImages < ActiveRecord::Migration
  def change
    create_table :user_twitter_post_images do |t|
      t.integer :uid, :null => false
      t.integer :image_id, :null => false
      t.timestamps
    end
    add_index :user_twitter_post_images, [:uid]
  end
end
