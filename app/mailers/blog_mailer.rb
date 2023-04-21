class BlogMailer < ApplicationMailer



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.blog_mailer.share_blog.subject
  #
  def share_blog(blog, user)
    @blog = blog
    @email = user.email

    attachments['Dev-Resume.pdf'] =  File.read('app/assets/attachments/Neeraj_Kumar_Fullstack_Resume.pdf')
    attachments.inline['logo.png'] = File.read('app/assets/attachments/bloggits.png')
    mail to: @email, subject: "Here is your blog on #{blog.title}"
  end
end
