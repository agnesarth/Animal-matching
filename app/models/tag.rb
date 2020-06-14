class Tag < ApplicationRecord
  has_many :tag_pets, dependent: :destroy
  has_many :pets, through: :tag_pets
  validates :value, uniqueness: true
end
