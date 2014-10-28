class User < ActiveRecord::Base
  validates :email, :first_name, :last_name, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true

  after_initialize :preset_session_token

  attr_reader :password

  has_many :statuses

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


  private
  def preset_session_token
    self.session_token = SecureRandom.urlsafe_base64(12)
  end

end
