User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

2.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
2.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[0..1]
followers = users[1..2]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }