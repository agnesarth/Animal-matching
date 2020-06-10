class Pet < ApplicationRecord
  after_create :new_pet_send
  after_update :new_match_send

  #belongs_to :user
  has_many :liker_likes, foreign_key: "liker", class_name: "Like", dependent: :destroy
  has_many :liked_likes, foreign_key: "liked", class_name: "Like", dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :tag_whos, dependent: :destroy
  has_many :tags, through: :tag_whos

  BREED=['Terrier','Dalmatien','Manx','Birman','Boxer','Berger Allemand','Labrador','Bouledogue','Chihuahua','Beagle','Setter','Cocker','Husky','Teckel','Persan','Siamois','Somali','Sibérien','Ragdoll'].sort

  def new_pet_send
    UserMailer.new_pet_email(self).deliver_now
  end

  def new_match_send
    UserMailer.new_match_email(self).deliver_now
  end

end
