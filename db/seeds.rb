User.create!(name:  "寒河江",
             email: "sagae5.28rujeae@gmail.com",
             password:              "s19930528",
             password_confirmation: "s19930528")

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

User.create!(name:  "京我",
             email: "zettainiakiramenaizo@gmail.com",
             password:              "s19930528",
             password_confirmation: "s19930528")
             
User.create!(name:  "田中",
             email: "aaaaaa@gmail.com",
             password:              "s19930528",
             password_confirmation: "s19930528")

User.create!(name:  "ttt",
             email: "bbbbbbbb@gmail.com",
             password:              "s19930528",
             password_confirmation: "s19930528")
             
User.create!(name:  "kkk",
             email: "kkkkk@gmail.com",
             password:              "s19930528",
             password_confirmation: "s19930528")
             
10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  job = "起業家"
  prefecture = "1"
  profile = "初めまして。初心者です。
　世界にない新しいサービスを発明したいと思います。若輩ものですが
　ご鞭撻のほどよろしくお願いします。特に好きな分野スクレイピングです。
　これまで速報サイトや株価チャートなどを製作してきました。これからは
　この技術を生かし、ビッグデータの収集を行いたいです。それからデータ
　を機械学習へと生かす事も考えてます。"
　blog = "https://teratail.com/users/s.k"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               job: job,
               prefecture: prefecture,
               profile: profile)
end

users = User.order(:created_at).take(6)
20.times do
  title = "もうすぐ完成するよ！もうすぐ完成するよ！"
  content = Faker::Lorem.sentence(10)
  purpose = 1
  users.each { |user| user.microposts.create!(title: title, content: content, purpose: purpose) }
end
20.times do
  title = "もうすぐ完成するよ！もうすぐ完成するよ！"
  content = Faker::Lorem.sentence(10)
  purpose = 2
  users.each { |user| user.microposts.create!(title: title, content: content, purpose: purpose) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[0..14]
followers = users[1..14]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
AdminUser.create!(email: 'sagae5.28rujeae@gmail.com', password: 's19930528', password_confirmation: 's19930528')