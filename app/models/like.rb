class Like < ApplicationRecord
    belongs_to :liker, class_name: "Pet"
    belongs_to :liked, class_name: "Pet"
    validates :liked, uniqueness: { scope: [:liker]}
    validate :different_pets

  def different_pets
    if self.liked == self.liker
      errors.add(:liked, 'Narcissism!')
      errors.add(:liker, 'Narcissism!')
    end
  end


end
