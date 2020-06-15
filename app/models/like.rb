class Like < ApplicationRecord
  after_update :new_match_user1
  after_update :new_match_user2

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

  def new_match_user1
    UserMailer.new_match_email1(self).deliver_now
  end

  def new_match_user2
    UserMailer.new_match_email2(self).deliver_now
  end
end
