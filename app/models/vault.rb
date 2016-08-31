class Vault < ActiveRecord::Base
  belongs_to :user
  has_many :snippets, :dependent => :delete_all

  validates_presence_of :name, :exposure, :user_id

  enum exposure: [ :private_vault, :unlisted_vault, :public_vault ]
end
