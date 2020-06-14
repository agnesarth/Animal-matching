class TagPet < ApplicationRecord
  belongs_to :tag
  belongs_to :pet
  validates :pet_id, uniqueness: { scope: :tag_id}

  def search.search(search)
    if search 
      tag = TagPet.find_by(name: search)
      if tag
        self.where(tag_id: tag)
      else
        Pet.all
      end
    else
      Pet.all
  end
end
