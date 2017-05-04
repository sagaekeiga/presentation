class Tag < ApplicationRecord
  has_many :microposts, dependent: :destroy, through: :taggings
  
  #---------------------------タグ
  has_many :taggings, dependent: :destroy
end
