class BlogArchiveJob
  include Sidekiq::Job

  def perform(blog_id)
    # Do something
    blog = Blog.friendly.find(blog_id)
    blog.toggle!(:archived)
    blog.save
  end
end
