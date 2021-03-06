class User < ApplicationRecord
  geocoded_by :full_address 
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.full_address_changed? }

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  after_create_commit :welcome_send

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,
    presence: true,
    length: { in: Devise.password_length },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :create

  validates :password,
    allow_nil: true,
    length: { in: Devise.password_length },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :update

  validates :email,
    uniqueness: true

  has_many :pets, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users, dependent: :destroy
  has_many :messages, dependent: :destroy

  def full_address
    [address, city, country].compact.join(', ')
  end  

  def full_address_changed?
    address_changed? || city_changed? || country_changed?
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def current_pet
    return Pet.find(self.default_pet_id)
  end

  def default_pet
    if self.pets.empty?
      return false
    elsif self.default_pet_id.nil?
      current_pet = self.pets.last
      self.default_pet_id.update(current_pet.id)
      return true
    else
      return true 
    end  
  end

  def name
    email.split('@')[0]
  end

end
