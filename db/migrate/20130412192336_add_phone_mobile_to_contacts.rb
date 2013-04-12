class AddPhoneMobileToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
    add_column :contacts, :mobile, :string
  end
end
