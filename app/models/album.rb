class Album < ActiveRecord::Base
  validates :user, :title, presence: true
  validates :title, uniqueness: { scope: :user }

  belongs_to :user, inverse_of: :albums
  has_many :photos, inverse_of: :album
end
