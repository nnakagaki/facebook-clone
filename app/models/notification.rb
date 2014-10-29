class Notification < ActiveRecord::Base
  validates :user, :post, :notifyable, presence: true

  belongs_to :user, inverse_of: :notifications
  belongs_to :post, inverse_of: :notifications
  belongs_to :notifyable, polymorphic: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :notified
end
