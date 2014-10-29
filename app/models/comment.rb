class Comment < ActiveRecord::Base
	validates :author, :post, :description, presence: true

	belongs_to :author,
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id,
		inverse_of: :comments

	belongs_to :post, inverse_of: :comments

  has_many :likes, as: :likable, dependent: :destroy

  has_many :notices, class_name: "Notification", as: :notifyable, dependent: :destroy
end
