class Pet < ApplicationRecord
  #after_create :new_pet_send
  after_create :default_pet
  before_destroy :reset_default_pet

  belongs_to :user
  has_many :likes_as_liker, foreign_key: "liker", class_name: "Like", dependent: :destroy
  has_many :likes_as_liked, foreign_key: "liked", class_name: "Like", dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :tag_pets, dependent: :destroy
  has_many :tags, through: :tag_pets
  validates :name, presence: true
  validates :birthdate, presence: true
  validates :animal, presence: true
  enum animal: [ :chat, :chien ]
#  validates :age, :numericality => {:greater_than => 0, message: "L'âge doit être supérieur à 0."}
  accepts_nested_attributes_for :tags
  CATBREED=['Manx','Birman','Persan','Siamois','Somali','Sibérien','Ragdoll', "Sphinx", "Européen","Autre"].sort
  DOGBREED=['Terrier','Dalmatien','Boxer','Berger Allemand','Labrador','Bouledogue','Chihuahua','Beagle','Setter','Cocker','Husky','Teckel', "Autre"].sort

  def age
    return ((Time.zone.now - self.birthdate.to_time) / 1.year.seconds).floor
  end
  def self.search(search)
    if search
      search_list = search.downcase.split(" ")
      list_compare = Pet.all
      search_list.each do |value|
        tag = Tag.find_by(value: value)
        if value == "chat" || value == "chien"
          list = Pet.where(animal: value)
        elsif value == "femelle" || value == "mâle"
          list = Pet.where(sex: value.capitalize)
        elsif value.to_f > 0 || value == "0"
          list = Pet.where(birthdate: (Date.today - (value.to_i + 1).to_i.years)..(Date.today - value.to_i.years))       
        elsif !tag.nil?
          list = tag.pets
        else
          list = Pet.all
        end
        tp list_compare = list & list_compare
      end
      return list_compare
    else
      return Pet.all
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

  def default_pet
    my_user = self.user
    if my_user.default_pet_id.nil?
      current_pet = my_user.pets.last
      my_user.update(default_pet_id: current_pet.id)
    end    
  end

  def reset_default_pet
    my_user = self.user
    if my_user.pets.size > 1
      last_other_pet = my_user.pets.where.not(id: self.id).last
      my_user.update(default_pet_id: last_other_pet.id)
    else
      my_user.update(default_pet_id: nil)
    end

  end

end
