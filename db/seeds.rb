# Create main test user
User.create!(name: "Test User", email: "test@testuser.com", password: "password123", password_confirmation: "password123", admin: true)

# Bulk generate test users
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@testuser.org"
  password = "password123"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end
