class AddProviderToServices < ActiveRecord::Migration
  def change
    add_column :services, :provider_id, :integer
    add_index :services, :provider_id
  end
end
