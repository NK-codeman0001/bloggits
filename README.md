
<p align="center">
  <img src="app/assets/images/bloggits-logo.png" alt="Bloggit Logo" width="200" height="200">
</p>

---

# Bloggit

Welcome to Bloggit, a sleek and powerful blogging platform that allows you to share your thoughts, ideas, and stories with the world. With its intuitive interface and rich features, Bloggit makes it easy to create and manage your own blog.

---

## Features

- **User-Friendly Interface**: Bloggit provides a clean and modern interface that ensures a seamless blogging experience for both writers and readers.

- **Multiple Blog Support**: You can create multiple blogs under your account and manage them effortlessly.

- **Customizable Themes**: Personalize the look and feel of your blog with a wide range of customizable themes to choose from.

- **Rich Text Editor**: The built-in rich text editor makes it easy to format and style your blog posts with a variety of fonts, colors, and media embeds.

- **Tags and Categories**: Organize your blog posts efficiently using tags and categories, making it easier for readers to navigate and discover content.

- **Social Sharing**: Enable social sharing buttons to allow readers to share your blog posts on popular social media platforms.

- **Commenting System**: Engage with your readers through the built-in commenting system, fostering discussion and community.

- **Authentication (Devise)**: Secure user authentication and registration functionality provided by the Devise gem.

- **Pagination (Pagy)**: Efficient and customizable pagination of blog posts, users, and other resources using the Pagy gem.

- **HTTP Server (Unicorn)**: Fast and reliable performance with the Unicorn HTTP server.

- **Web Server (Nginx)**: Serving static files and proxying requests to Unicorn for optimized web serving.

- **Emails (Mail)**: Sending emails from the application, including account activation and password reset emails.

- **Third-Party Authentication (Omniauth)**: Integration with third-party providers such as Twitter, Facebook, LinkedIn, and Google for seamless login and registration.

- **jQuery Integration (jquery-rails)**: Easy integration of jQuery library for enhanced frontend interactivity.

- **CSS Framework (tailwindcss-rails)**: Integration of the Tailwind CSS framework for easy styling and responsive design.

- **Background Processing (Sidekiq)**: Background processing of jobs such as sending emails and fetching blog data using the Sidekiq library.

- **HTML/XML Parsing (Nokogiri)**: Parsing and manipulating HTML/XML documents for various functionalities, such as fetching blog data.

- **Website Automation (Mechanize)**: Automating interactions with websites for tasks such as fetching external blog data.

- **API Documentation (Rswag)**: Easy documentation and testing of APIs using the Rswag framework.

- **JSON Serialization (Active Model Serializers)**: Flexible JSON serialization of ActiveRecord models using Active Model Serializers.

- **Admin Interface (Rails Admin)**: Admin interface for managing and interacting with data in the application.

- **Friendly URLs (FriendlyId)**: Creation of user-friendly URLs and slugs for ActiveRecord models.

---

## System Requirements

Make sure your system meets the following requirements:

- Ruby (version >= 2.5.0)
- Ruby on Rails (version >= 6.0.0)
- PostgreSQL (version >= 9.3)

---

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/NK-codeman0001/bloggits.git
   ```

2. Navigate to the project directory:

   ```bash
   cd bloggits
   ```

3. Install dependencies using Bundler:

   ```bash
   bundle install
   ```

4. Set up the database:

   ```bash
   rails db:setup
   ```

5. Run database migrations:

   ```bash
   rails db:migrate
   ```

6. Set up Omniauth Environment Variables:
   Open the config/initializers/devise.rb file and locate the Omniauth configuration section. Uncomment the provider lines for the providers you want to use (Twitter, Facebook, LinkedIn, Google) and replace the ENV['API_KEY'] and ENV['API_SECRET'] with your actual API key and secret. For example:

       config.omniauth :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
       config.omniauth :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
       config.omniauth :linkedin, ENV['LINKEDIN_CLIENT_ID'], ENV['LINKEDIN_CLIENT_SECRET']
       config.omniauth :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']

   Save the file.


7. Seed the database with sample data:

   ```bash
   rails db:seed
   ```

   This will create sample blog posts, users, and other necessary data.

8. Start the Rails server:

   ```bash
   rails server
   ```

   The app will be running at `http://localhost:3000`.

---

## Fetching Blog Data

You can fetch all blogs on rubyonrails.org using the following rake command:

```bash
rails blogs:fetch_all_rails_blog
```

This will fetch all the blog posts from rubyo.org and add them to your blog's database.

---

## Contributing

Contributions are welcome! If you have any ideas, bug fixes, or improvements, please submit a pull request. For major changes, please open an issue first to discuss the changes.

---

## Gems Used

Here are some of the key gems used in this application:

- **Devise**: Flexible authentication solution for Rails applications.
- **Pagy**: Lightweight and customizable pagination library.
- **Unicorn**: HTTP server for fast and reliable performance.
- **Nginx**: Web server for serving static files and proxying requests to Unicorn.
- **Mail**: Library for sending emails from Rails applications.
- **Omniauth**: Provides authentication through third-party providers such as Twitter, Facebook, LinkedIn, and Google.
- **jquery-rails**: Helps with jQuery integration in Rails applications.
- **tailwindcss-rails**: Integrates the Tailwind CSS framework with Rails applications.
- **Sidekiq**: Background processing library for executing jobs asynchronously.
- **Nokogiri**: Library for parsing and manipulating XML and HTML documents.
- **Mechanize**: Library for automating interactions with websites.
- **Rswag**: Framework for documenting and testing APIs in Rails applications.
- **Active Model Serializers**: Helps with JSON serialization in Rails applications.
- **Rails Admin**: Provides an admin interface for managing data in Rails applications.
- **FriendlyId**: Allows for friendly URLs and slugs for ActiveRecord models.

For a complete list of gems and their versions, please check the `Gemfile` and `Gemfile.lock` files.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---
