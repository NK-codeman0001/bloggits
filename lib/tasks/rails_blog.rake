desc "Fetch rails blogs"
task :fetch_rails_blogs => :environment do

  require 'nokogiri'
  require 'open-uri'

  doc = Nokogiri::HTML4(URI.open('https://rubyonrails.org/blog/'))

  doc.css('.blog__post').each do |blog_post|
    title = blog_post.at_css('a').text  
    content = blog_post.at_css('dd')
    published_at = blog_post.at_css('h6').text

    blog = Blog.where(title: title).first_or_initialize
    blog.update(
      content: content,
      published_at: published_at
    )

  end
end