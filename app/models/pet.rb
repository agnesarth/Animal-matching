class Pet < ApplicationRecord
  #after_commit :new_pet_send

  belongs_to :user
  has_many :likes_as_liker, foreign_key: "liker", class_name: "Like", dependent: :destroy
  has_many :likes_as_liked, foreign_key: "liked", class_name: "Like", dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :tag_pets, dependent: :destroy
  has_many :tags, through: :tag_pets
  validates :animal, presence: true
  enum animal: [ :chat, :chien ]
  validates :age, :numericality => {:greater_than => 0, message: "L'âge doit être supérieur à 0."}
  accepts_nested_attributes_for :tags
  CATBREED=['Manx','Birman','Persan','Siamois','Somali','Sibérien','Ragdoll', "Sphinx", "Européen"].sort
  DOGBREED=['Terrier','Dalmatien','Boxer','Berger Allemand','Labrador','Bouledogue','Chihuahua','Beagle','Setter','Cocker','Husky','Teckel'].sort

  def self.search(search)
    if search 
      tag = Tag.where(value: search)
      if tag
        self.joins(:tags).where(tags: tag)
      else
        Pet.all
      end
    else
      Pet.all
    end
  end
  
  

  def new_pet_send
    UserMailer.new_pet_email(self).deliver_now
  end

  def short_description
    unless self.description.nil?
      short = self.description.split(" ").slice(0,13).join(" ")
      if short.last != "."
        short = short + " ..."
      end
      return short
    end
  end


end
 