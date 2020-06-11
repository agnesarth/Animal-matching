class TagPet < ApplicationRecord
  belongs_to :tag
  belongs_to :pet
  validates :pet_id, uniqueness: { scope: :tag_id}
end
