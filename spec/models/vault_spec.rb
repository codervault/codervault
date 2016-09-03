require 'rails_helper'

RSpec.describe Vault, type: :model do

  it "name should be present" do
    vault = build(:vault, name: ' ')
    expect(vault).not_to be_valid
  end

  it "exposure should be present" do
    vault = build(:vault, exposure: ' ')
    expect(vault).not_to be_valid
  end

  it "user_id should be present" do
    vault = build(:vault, user_id: ' ')
    expect(vault).not_to be_valid
  end

  it "should belongs to user" do
    user = create(:user)
    vault = create(:vault, user_id: user.id)
    expect(vault.user).to eq(user)
  end

  it "has many snippets" do
    vault = vault = create(:vault)
    create(:snippet, vault_id: vault.id)
    create(:snippet, vault_id: vault.id)
    expect(vault.snippets.size).to eq(2)
  end

  it "has 0 snippets when vault is deleted" do
    vault = vault = create(:vault)
    create(:snippet, vault_id: vault.id)
    create(:snippet, vault_id: vault.id)
    Vault.destroy(vault)
    expect(vault.snippets.size).to eq(0)
  end
end
