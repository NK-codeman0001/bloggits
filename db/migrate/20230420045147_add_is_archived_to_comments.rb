class AddIsArchivedToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :is_archived, :boolean, default: false
  end
end
