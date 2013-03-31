class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :email

      t.timestamps
    end
    add_index :contacts, :name, :unique => true
  end
end
