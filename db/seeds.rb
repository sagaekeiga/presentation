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
             
Tag.create!(name:  "Ruby on Rails")
Tag.create!(name:  "Javascript")
Tag.create!(name:  "PHP")
Tag.create!(name:  "Java")
Tag.create!(name:  "Python")
Tag.create!(name:  "C++")
Tag.create!(name:  "C")
Tag.create!(name:  "jQuery")
Tag.create!(name:  "VR")
Tag.create!(name:  "VPS")
Tag.create!(name:  "AWS")
Tag.create!(name:  "アルゴリズム")
Tag.create!(name:  "Cloud9")
Tag.create!(name:  "Atom")
Tag.create!(name:  "IDLE")
Tag.create!(name:  "Mac")
Tag.create!(name:  "Windows")
Tag.create!(name:  "コマンドプロンプト")
Tag.create!(name:  "ターミナル")
Tag.create!(name:  "API")
Tag.create!(name:  "Django")
Tag.create!(name:  "CakePHP")
Tag.create!(name:  "Nginx")
Tag.create!(name:  "apache")
Tag.create!(name:  "unicorn")
Tag.create!(name:  "サーバ")
Tag.create!(name:  "Node.js")
Tag.create!(name:  "機械学習")
Tag.create!(name:  "深層学習")
Tag.create!(name:  "自然言語処理")
Tag.create!(name:  "スクレイピング")
Tag.create!(name:  "アジャイル")
Tag.create!(name:  "ウォーターフロント")
Tag.create!(name:  "OS")
Tag.create!(name:  "Linux")
Tag.create!(name:  "Android")
Tag.create!(name:  "iOS")
Tag.create!(name:  "Webアプリケーション")
Tag.create!(name:  "脆弱性")
Tag.create!(name:  "セキュリティ")
Tag.create!(name:  "HTML5")
Tag.create!(name:  "CSS3")
Tag.create!(name:  "CSS")
Tag.create!(name:  "ネットワーク")
Tag.create!(name:  "プロトコル")
Tag.create!(name:  "TCP")
             
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

2.times do
  title = "もうすぐ完成するよ！もうすぐ完成するよ！"
  content = Faker::Lorem.sentence(10)
  purpose = 2
  palace = true
  users.each { |user| user.microposts.create!(title: title, content: content, purpose: purpose, palace: palace) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[0..14]
followers = users[1..14]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
AdminUser.create!(email: 'sagae5.28rujeae@gmail.com', password: 's19930528', password_confirmation: 's19930528')