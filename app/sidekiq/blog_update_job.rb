class BlogUpdateJob
  include Sidekiq::Job

  def perform(blog_id, params)
    # Do something
    blog = Blog.find(blog_id)
    blog.update(params)

  end
end
