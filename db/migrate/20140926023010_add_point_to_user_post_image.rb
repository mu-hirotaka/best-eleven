class AddPointToUserPostImage < ActiveRecord::Migration
  def change
    add_column :user_post_images, :point, :integer, :default => 0
  end
end
