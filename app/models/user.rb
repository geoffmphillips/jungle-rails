class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, presence: true
  validates_length_of :password, minimum: 5
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials params
    @user = User.find_by email: params[:email]
    @user.authenticate params[:password]
  end

end
