class CreateConsumerContacts < ActiveRecord::Migration
  def change
    create_table :consumer_contacts do |t|
      t.references :consumer
      t.references :contact
      t.string :role
      t.timestamps
      t.date :deleted_at
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :consumer_contacts, :consumer_id
    add_index :consumer_contacts, :contact_id
    add_index :consumer_contacts, [:consumer_id,:contact_id,:role], :unique => true
    
  end
end
