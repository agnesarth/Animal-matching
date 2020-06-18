class Message < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user

  validates :content, presence: true, allow_blank: false
  
=======
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  belongs_to :user
  belongs_to :chatroom
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}


  def timestamp
    created_at.strftime('%d/%m/%Y %H:%M ')
  end
>>>>>>> 552335cc13edfa9e8f3d019836c44a24d0b6bb9d
end
