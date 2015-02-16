class CreatePlayerCounters < ActiveRecord::Migration
  def change
    create_table :player_counters do |t|
      t.integer :qid, :null => false
      t.integer :pid, :null => false
      t.integer :num, :null => false
      t.timestamps
    end
    add_index :player_counters, [:qid]
  end
end
