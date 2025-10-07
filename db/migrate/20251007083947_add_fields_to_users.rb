class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :avatar_url, :string
    add_column :users, :bio, :text

    add_index :users, :role
  end
end
