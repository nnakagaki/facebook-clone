class Friend < ActiveRecord::Base
  validates :friend_id, :friended_id, presence: true
  validates :friend_id, uniqueness: { scope: :friended_id, message: "Already Friends!"}
end
