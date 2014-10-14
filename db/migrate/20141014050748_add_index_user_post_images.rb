class AddIndexUserPostImages < ActiveRecord::Migration
  def change
    add_index :user_post_images, [:question_id, :point]
  end
end
