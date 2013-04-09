class AddUserstampColumns < ActiveRecord::Migration
  def change
    add_column :consumers, :updated_by,:integer
    add_column :consumers, :created_by,:integer

    add_column :contacts, :updated_by,:integer
    add_column :contacts, :created_by,:integer

    add_column :providers, :updated_by,:integer
    add_column :providers, :created_by,:integer

    add_column :services, :updated_by,:integer
    add_column :services, :created_by,:integer

    add_column :subscriptions, :updated_by,:integer
    add_column :subscriptions, :created_by,:integer

    add_column :users, :updated_by,:integer
    add_column :users, :created_by,:integer
  end
end
