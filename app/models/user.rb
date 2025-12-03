class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 15 }
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :private_messages, dependent: :destroy
  has_secure_password


  def appear
    update(last_seen_at: Time.current)

    broadcast_remove_to "user_status"
    broadcast_prepend_to "user_status", target: "users_online", partial: "users/user_status", locals: { user: self }
  end

  def disappear
    update(last_seen_at: nil) # Lub czas z przeszłości

    broadcast_remove_to "user_status"
    broadcast_prepend_to "user_status", target: "users_offline", partial: "users/user_status", locals: { user: self }
  end
  def online?
    return false if last_seen_at.nil?
    last_seen_at > 1.minutes.ago
  end
end
