require 'rails_helper'

RSpec.describe Vault, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:snippets).dependent(:delete_all) }
  it { should validate_presence_of(:name).on(:create) }
  it { should validate_presence_of(:exposure).on(:create) }
  it { should validate_presence_of(:user_id).on(:create) }
  it { should define_enum_for(:exposure) }
end
