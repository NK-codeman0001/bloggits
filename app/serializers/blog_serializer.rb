class BlogSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :content, :url
  delegate :current_user, to: :scope

  # has_rich_text :content
  has_many :comments
  def url
    blog_url(object, host: 'localhost:3000') if current_user.is_admin
  end
end
