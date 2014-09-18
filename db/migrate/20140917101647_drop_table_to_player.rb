class DropTableToPlayer < ActiveRecord::Migration
  def change
    drop_table :players
  end
end
