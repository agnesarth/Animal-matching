class Like < ApplicationRecord
  belongs_to :liker, class_name: "Pet"
  belongs_to :liked, class_name: "Pet"
  validates :liked, uniqueness: { scope: [:liker]}
  validate :different_pets

  def different_pets
    if self.liked == self.liker
      errors.add(:liked, 'Narcissisme!')
      errors.add(:liker, 'Narcissisme!')
    end
  end

  def current_pet
    current_pet = Pet.find(current_user.default_pet_id)
  end

  def already_liked?
    liker_pet = Pet.find(self.liked_id)
    liked_pet = Pet.find(self.liker_id)
    return liker_pet.likes_as_liker.where(liked_id: liked_pet).exists?
  end

  def matches_back
    liker_pet = Pet.find(self.liked_id)
    liked_pet = Pet.find(self.liker_id)
    if already_liked?
      self.match = true
      back_like = liked_pet.likes_as_liked.where(liker_id: liker_pet)
      back_like.update(match: true)
    end
  end

  def unmatch
    liker_pet = Pet.find(self.liked_id)
    liked_pet = Pet.find(self.liker_id)
    if already_liked?
      self.match = true
      back_like = liked_pet.likes_as_liked.where(liker_id: liker_pet)
      back_like.update(match: true)
    end
    
    iam_liked_ids = current_pet.likes_as_liked.all
    unmatched = iam_liked_ids.where(liker: other_pet)
    unmatched.update(match: false)
  end

end
