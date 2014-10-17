class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances, :options => 'ENGINE=MyISAM' do |t|
      t.integer :valid, :null => false
      t.timestamps
    end
  end
end
