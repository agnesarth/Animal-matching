class User < ApplicationRecord
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  #after_commit :welcome_send
  #before_action :default_pet

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
      redirect_to users_path
      return true
    else
      redirect_to users_path
      return true 
    end
    
  end

end
