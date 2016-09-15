class User < ActiveRecord::Base
  has_many :vaults, :dependent => :delete_all

  VALID_USERNAME_REGEX = /\A[\w\s-]*\z/i

  validates :username, presence: true, uniqueness: true, length: { in: 3..18 }, format: { with: VALID_USERNAME_REGEX }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # overwrite the default param :id to :username
  # /users/1 to /users/mike
  def to_param
    username
  end
end