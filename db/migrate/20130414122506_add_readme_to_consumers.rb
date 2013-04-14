class AddReadmeToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :readme_id, :integer
  end
end
