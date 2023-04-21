class BlogMailer < ApplicationMailer



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.blog_mailer.share_blog.subject
  #
  def share_blog(blog, user)
    @blog = blog
    @email = user.email
    mail to: @email, subject: "Here is your blog on #{blog.title}"
  end
end
