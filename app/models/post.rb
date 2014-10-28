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

	has_many :comments, inverse_of: :post
end
