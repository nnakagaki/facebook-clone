class Photo < ActiveRecord::Base
  validates :user, :album, :url, :post, presence: true

  belongs_to :user, inverse_of: :photos
  belongs_to :album, inverse_of: :photos
  belongs_to :post
end
