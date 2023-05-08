desc "Fetch all rails blogs - Mechanize"
task :fetch_all_rails_blogs => :environment do

  require 'mechanize'

  agent = Mechanize.new
  full_link="https://rubyonrails.org/blog"  # 158 pages
  loop do
    page = agent.get(full_link)
  
    # Select all blog post titles on the current page
    titles = page.search('.blog__post a').map(&:text)
    blog_links = page.search('.blog__post').map{|post| post.at('a')[:href]}
    
    
    blog_links.each do |link|
      # fetch the blog page
      full_blog_link = URI.join(page.uri, link)
      blog_page = agent.get(full_blog_link)

      # use Nokogiri to scrape the blog title, author name, and publication date
      # author = blog_page.css('h6').text.strip
      title = blog_page.css('h2').text.strip
      content = blog_page.css('.common-content--post').text.strip
      date = Date.parse(blog_page.css('.common-headline h5').text.strip)

      blog = Blog.where(title: title).first_or_initialize
      blog.update(
      content: content,
      published_at: date
      )
    end
    
  
    # Break out of the loop if there are no more pages
    element = page.search('.blog__pagination').first
    break if element.nil?
    link = element.at('a')[:href]
    full_link = URI.join(page.uri, link).to_s
  
  end
  
end