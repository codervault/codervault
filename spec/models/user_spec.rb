require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:vaults).dependent(:delete_all) }
  it { should validate_presence_of(:email).on(:create) }
  it { should validate_presence_of(:password).on(:create) }
  it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
end
