require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  it "has many vaults" do
    create_list(:vault, 2, user_id: user.id)
    expect(user.vaults.size).to eq(2)
  end

  it "has 0 vaults when user is deleted" do
    User.delete(user.id)
    expect(user.vaults.size).to eq(0)
  end
end