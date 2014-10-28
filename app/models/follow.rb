class Follow < ActiveRecord::Base
  validates :user, :post, presence: true
  validates :user, uniqueness: { scope: :post, message: "already following post"}

  belongs_to :user, inverse_of: :follows
  belongs_to :post, inverse_of: :follows
end
