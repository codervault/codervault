class User < ActiveRecord::Base

  VALID_USERNAME_REGEX = /\A[\w\s-]*\z/i

  has_many :vaults, :dependent => :delete_all

  validates :username, presence: true, uniqueness: true, length: { in: 3..18 }, format: { with: VALID_USERNAME_REGEX }

  has_attached_file :avatar, styles: { thumb: "100x100" },
                    default_url: '/assets/default_avatar.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end