class CreateProviderContacts < ActiveRecord::Migration
  def change
    create_table :provider_contacts do |t|
      t.references :provider
      t.references :contact
      t.string :role
      t.timestamps
      t.date :deleted_at
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :provider_contacts, :provider_id
    add_index :provider_contacts, :contact_id
    add_index :provider_contacts, [:provider_id,:contact_id,:role], :unique => true
  end
end
