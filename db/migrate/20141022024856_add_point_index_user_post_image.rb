class AddPointIndexUserPostImage < ActiveRecord::Migration
  def change
    add_index :user_post_images, [:point]
  end
end
