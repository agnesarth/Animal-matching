class User < ApplicationRecord
  geocoded_by :full_street_address   
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  #after_create :welcome_send

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets, dependent: :destroy

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def full_street_address  
  end
end
