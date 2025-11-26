class Message < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { minimum: 1, maximum: 1000 }
  scope :custom_display, ->(start_time = nil) { 
    if start_time
      where("created_at > ?", start_time).order(:created_at)
    else
      order(:created_at).last(20)
    end
  }
end
