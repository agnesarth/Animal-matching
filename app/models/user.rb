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
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Votre adresse email est erronée" }

  has_many :pets, dependent: :destroy

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def current_pet
    return Pet.find(self.default_pet_id)
  end

  def default_pet?
    return self.default_pet_id.nil?
  end

  def default_pet!
    if self.default_pet_id.nil?
      last_pet = self.pets.last
      self.update(default_pet_id: last_pet.id)
    end
  end

end
