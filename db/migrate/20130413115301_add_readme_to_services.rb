class AddReadmeToServices < ActiveRecord::Migration
  def change
    add_column :services, :readme_id, :integer
  end
end
