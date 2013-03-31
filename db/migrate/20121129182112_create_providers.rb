class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name, :null => false
      t.string :identifier

      t.timestamps
    end
    add_index :providers, :name, :unique => true
  end
end
