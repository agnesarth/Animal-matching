class Pet < ApplicationRecord
  #belongs_to :user
  has_many :liker_likes, foreign_key: "liker", class_name: "Like", dependent: :destroy
  has_many :liked_likes, foreign_key: "liked", class_name: "Like", dependent: :destroy
  has_many_attached :photos

  BREED=['Terrier','Dalmatien','Manx','Birman','Boxer','Berger Allemand','Labrador','Bouledogue','Chihuahua','Beagle','Setter','Cocker','Husky','Teckel','Persan','Siamois','Somali','Sibérien','Ragdoll'].sort
end
