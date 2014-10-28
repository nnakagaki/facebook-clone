class Comment < ActiveRecord::Base
	validates :author, :post, :description, presence: true

	belongs_to :author,
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id,
		inverse_of: :comments

	belongs_to :post, inverse_of: :comments
end
