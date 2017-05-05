class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :profile, length: { maximum: 110 }
  validates :prefecture, length: { maximum: 20 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :job, length: { maximum: 10 }
  validates :blog, length: { maximum: 30 }
  
  has_many :microposts, dependent: :destroy

  #---------------------------フォロー
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :followed #フォローしている人を表示できるメソッドを関連づける
  has_many :followers, through: :passive_relationships, source: :follower #フォローされている人を表示できるメソッドを関連付ける
  
  #---------------------------いいね！
  has_many :likes, dependent: :destroy
  has_many :like_microposts, through: :likes, source: :micropost

  #---------------------------コメント
  has_many :comments

  #---------------------------クリップ！
  has_many :clips, dependent: :destroy
  has_many :clip_microposts, through: :clips, source: :micropost

  #------------ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #--------ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #---------現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params, *options)
  end
  

end
