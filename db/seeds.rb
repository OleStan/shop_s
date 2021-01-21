# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create([{ name: 'Computer' },
                 { name: 'Clouth' },
                 { name: 'Food' },
                 { name: 'For Kids' },
                 { name: 'Computer_child', ancestry: '1' }])
25.times do
  Product.create(name: Faker::Food.dish,
                 price: rand(0.1..500.00),
                 about: Faker::Food.description,
                 config:Faker::Food.ingredient + Faker::Food.ingredient + Faker::Food.ingredient,
                 article: rand(100_000..999_999),
                 factory: '111',
                 category_id: '3')
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?