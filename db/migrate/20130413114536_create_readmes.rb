class CreateReadmes < ActiveRecord::Migration
  def change
    create_table :readmes do |t|
      t.text :text
      t.date :deleted_at
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
