class DestroyUserBoketeImages < ActiveRecord::Migration
  def change
    drop_table :user_bokete_images
  end
end
