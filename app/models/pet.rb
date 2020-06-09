class Pet < ApplicationRecord
  belongs_to :user
  has_many :liker_likes, foreign_key: 'liker', class_name: "Like", dependent: :destroy
  has_many :liked_likes, foreign_key: 'liked', class_name: "Like", dependent: :destroy
  #has_many: :photos
end
