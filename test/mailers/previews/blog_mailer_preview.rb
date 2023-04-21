# Preview all emails at http://localhost:3000/rails/mailers/blog_mailer
class BlogMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/blog_mailer/share_blog
  def share_blog
    BlogMailer.share_blog
  end

end
