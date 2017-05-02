class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 70 }
  validates :purpose, presence: true
  default_scope -> { order(created_at: :desc) }
  paginates_per 20

  acts_as_taggable_on :skills # post.label_list が追加される

  #--------------------いいね！
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user 

  #---------------------コメント
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :likes, source: :user 

  #--------------------クリップ！
  has_many :clips, dependent: :destroy
  has_many :clip_users, through: :clips, source: :user 
  
  #お気に入りしているかどうかを返す
  def liked_by? user
     likes.where(user_id: user.id).exists?
  end
  
  #お気に入りしているかどうかを返す
  def cliped_by? user
     clips.where(user_id: user.id).exists?
  end
end
