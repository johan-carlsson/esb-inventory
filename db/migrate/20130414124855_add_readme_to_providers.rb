class AddReadmeToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :readme_id, :integer
  end
end
