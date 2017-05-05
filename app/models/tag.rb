class Tag < ApplicationRecord
  ALLOWED_PARAMS = [:id, :name]
  has_many :microposts, dependent: :destroy, through: :taggings
  
  #---------------------------タグ
  has_many :taggings, dependent: :destroy
end
