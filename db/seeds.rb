# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Destroy existing records
Restaurant.destroy_all
User.destroy_all
Review.destroy_all

# Create a restaurant
restaurant = Restaurant.create!(name: "Le Bistrot Moderne")

# Create users with classic names
usernames = %w[John Alice Robert Emma Michael Sophia David Olivia Daniel Mia]
users = usernames.map { |name| User.create!(username: name) }

# Create reviews (25 per category: service, food, ambiance)
categories = %w[service food ambiance]

categories.each do |category|
  25.times do
    Review.create!(
      user: users.sample,         # Random user from the list
      restaurant: restaurant,     # Associate with the restaurant
      rating: rand(1..5),         # Random rating between 1 and 5
      category: category,         # Fixed category for this batch
      comment: Faker::Restaurant.review, # Generate realistic restaurant comments
      date: Time.now - (rand(0..6).days) # Random date within the last 7 days
    )
  end
end

puts "Seeding complete!"
puts "#{Restaurant.count} restaurant(s) created."
puts "#{User.count} user(s) created."
puts "#{Review.count} review(s) created (25 per category)."
