class BlogUpdateJob
  include Sidekiq::Job

  def perform(blog_id, params)
    # Do something
    blog = Blog.friendly.find(blog_id)
    blog.update(params)
    blog.slug = blog.title.parameterize
    blog.save!

  end
end
