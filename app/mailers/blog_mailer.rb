
class BlogMailer < ApplicationMailer



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.blog_mailer.share_blog.subject
  #
  def share_blog(blog, user)
    @blog = blog
    @email = user.email

    attachments['Dev-Resume.pdf'] =  File.read(Rails.root.join('app/assets/attachments','Neeraj_Kumar_Fullstack_Resume.pdf'))
    attachments.inline['bloggits.jpeg'] = File.read(Rails.root.join('app/assets/attachments','bloggits.jpeg'))
    mail to: @email, subject: "Here is your blog on #{blog.title}"
  end
end
