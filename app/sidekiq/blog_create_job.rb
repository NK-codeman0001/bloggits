class BlogCreateJob
  include Sidekiq::Job

  def perform(blog_params)
    # Do something
    blog = Blog.new(blog_params)
    # return if blog.save?
    blog.save
    blog.title
  end
end
