# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

adminuser = User.where(email: "admin.user@bloggits.com").first_or_initialize

adminuser.update(
  password: "changeit",
  password_confirmation: "changeit"
)


100.times do |i|
  blog = Blog.where(title: "Demo Blog: #{i+1}").first_or_initialize
  blog.update(
    content: "This is seeded content no- #{i+1}",
    published_at: Time.current
  )
end