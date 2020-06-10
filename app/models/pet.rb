class Pet < ApplicationRecord
  belongs_to :user
  has_many :liker_likes, foreign_key: "liker", class_name: "Like", dependent: :destroy
  has_many :liked_likes, foreign_key: "liked", class_name: "Like", dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :tag_whos, dependent: :destroy
  has_many :tags, through: :tag_whos

  BREED=['Terrier','Dalmatien','Manx','Birman','Boxer','Berger Allemand','Labrador','Bouledogue','Chihuahua','Beagle','Setter','Cocker','Husky','Teckel','Persan','Siamois','Somali','Sibérien','Ragdoll'].sort
end
