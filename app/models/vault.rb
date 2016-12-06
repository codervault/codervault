class Vault < ActiveRecord::Base
  include PathFormatter

  belongs_to :user
  has_many :snippets, :dependent => :delete_all

  validates_presence_of :name, :exposure, :user_id

  before_save :format_name

  enum exposure: [ :private_vault, :unlisted_vault, :public_vault ]

  delegate :username, to: :user, prefix: true

  def self.find_vault(name)
    name.gsub!('-', ' ')
    find_by_name(name)
  end
end