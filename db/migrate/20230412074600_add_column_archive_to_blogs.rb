class AddColumnArchiveToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :archived, :boolean, default: false
  end
end
