class Message < ActiveRecord::Base
  validates :user, :chat_id, :message, presence: true

  belongs_to :user, inverse_of: :messages
end
