class Like < ActiveRecord::Base
  validates :user, :likable, presence: true

  belongs_to :likable, polymorphic: true
  belongs_to :user, inverse_of: :likes

  has_many :notices, class_name: "Notification", as: :notifyable, dependent: :destroy
end
