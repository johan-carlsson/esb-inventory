class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :service
      t.references :consumer
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
    add_index :subscriptions, :service_id
    add_index :subscriptions, :consumer_id
  end
end
