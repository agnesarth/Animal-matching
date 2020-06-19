class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages
  accepts_nested_attributes_for :chatroom_users

  def other_user(user)
    self.users.each do |u|
      if u != user
        return User.find(u.id)
      end
    end
  end

end
