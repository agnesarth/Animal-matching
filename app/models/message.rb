class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  belongs_to :user
  belongs_to :chatroom
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  def timestamp
    created_at.strftime('%d/%m %H:%M ')
  end
  
end

