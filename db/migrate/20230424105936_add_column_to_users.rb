class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
