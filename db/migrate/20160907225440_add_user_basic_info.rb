class AddUserBasicInfo < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :full_name, :string
    add_column :users, :bio, :text
    add_column :users, :url, :string

    add_index :users, :username, unique: true
  end
end
