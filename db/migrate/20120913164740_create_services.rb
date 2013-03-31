class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, :null => false
      t.string :category

      t.timestamps
    end
    add_index :services, [:name,:category], :unique => true
  end
end
