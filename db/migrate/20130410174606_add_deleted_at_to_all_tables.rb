class AddDeletedAtToAllTables < ActiveRecord::Migration
  def change
   add_column :consumers, :deleted_at,:timestamp
   add_column :contacts, :deleted_at,:timestamp
   add_column :providers, :deleted_at,:timestamp
   add_column :services, :deleted_at,:timestamp
   add_column :subscriptions, :deleted_at,:timestamp
   add_column :users, :deleted_at,:timestamp
  end
end
