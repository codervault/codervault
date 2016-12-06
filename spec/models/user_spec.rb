require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:vaults).dependent(:delete_all) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }

  it "#to_param" do
    user = build_stubbed(:user)
    expect(user.to_param).to eq(user.username)
  end
end