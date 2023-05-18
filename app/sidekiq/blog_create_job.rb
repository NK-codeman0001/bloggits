class BlogCreateJob
  include Sidekiq::Job

  def perform(blog_params)
    # Do something
    blog = Blog.new(blog_params)
    blog.slug = blog.title.parameterize
    # return if blog.save?
    blog.save!
  end
end
