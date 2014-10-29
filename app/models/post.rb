class Post < ActiveRecord::Base
	validates :author, :wall_user, :description, presence: true

	belongs_to :author,
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id,
		inverse_of: :authored_posts

	belongs_to :wall_user,
		class_name: "User",
		foreign_key: :userwall_id,
		primary_key: :id,
		inverse_of: :wall_posts

	has_many :comments, dependent: :destroy, inverse_of: :post

  has_many :likes, as: :likable, dependent: :destroy

  has_many :follows, dependent: :destroy, inverse_of: :post

  has_many :followers, through: :follows, source: :user

  has_many :notifications, dependent: :destroy, inverse_of: :post

  has_many :notices, class_name: "Notification", as: :notifyable, dependent: :destroy
end
