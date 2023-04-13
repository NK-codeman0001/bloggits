class AddPublishedAtToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :published_at, :datetime
  end
end
