class FriendRequest < ActiveRecord::Base
  validates :requestor, :requested, presence: true

  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :friend_requests_to_be_accepted

  belongs_to :requested,
    class_name: "User",
    foreign_key: :requested_id,
    primary_key: :id,
    inverse_of: :friend_requests_to_accept

end
