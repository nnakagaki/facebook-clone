class User < ActiveRecord::Base
  validates :email, :first_name, :last_name, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true

  after_initialize :preset_session_token

  attr_reader :password

  include PgSearch
  pg_search_scope :search_by_full_name,
    :against => [:first_name, :last_name],
    :using => { :tsearch => {:prefix => true} }

  has_many :authored_posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author

  has_many :wall_posts,
    class_name: "Post",
    foreign_key: :userwall_id,
    primary_key: :id,
    inverse_of: :wall_user

  has_many :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author

  has_many :likes, inverse_of: :user

  has_many :friend_requests_to_be_accepted,
    class_name: "FriendRequest",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :requestor

  has_many :friend_requests_to_accept,
    class_name: "FriendRequest",
    foreign_key: :requested_id,
    primary_key: :id,
    inverse_of: :requested

  has_many :follows, inverse_of: :user

  has_many :notifications, inverse_of: :user

  has_many :notified,
    class_name: "Notification",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author


  def self.find_by_credentials(user_params)
    @user = User.find_by_email(user_params[:email])
    @user && @user.is_password?(user_params[:password]) ? @user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(12)
    self.save
    return self.session_token
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def recent_posts_and_comments
    result = []
    self.wall_posts.each do |post|
      result.push({post => post.comments.to_a})
    end

    result.sort! { |post1, post2|

    }

    result
  end

  def post_sort
    self.wall_posts.sort { |post1, post2|
      post2.created_at <=> post1.created_at
    }
  end

  def friends
    friends = [];
    Friend.where(friend_id: self.id).each do |friendship|
      friends.push(friendship.friended_id)
    end

    Friend.where(friended_id: self.id).each do |friendship|
      friends.push(friendship.friend_id) unless friends.include?(friendship.friend_id)
    end

    friends
  end

  def friends_with?(user)
    self.friends.each do |friend_id|
      return true if friend_id == user.id
    end

    false
  end

  def requested_friendship?(user)
    self.friend_requests_to_be_accepted.each do |request|
      return true if request.requested_id == user.id
    end

    false
  end


  private
  def preset_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(12)
  end

end
