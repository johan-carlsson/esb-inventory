class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :name, :null => false
      t.string :identifier

      t.timestamps
    end
   add_index :consumers, :name, :unique => true 
  end
end
