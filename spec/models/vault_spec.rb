require 'rails_helper'

RSpec.describe Vault, type: :model do

  let(:vault) { create(:vault) }

  it "name should be present" do
    vault.name = ' '
    expect(vault).not_to be_valid
  end

  it "exposure should be present" do
    vault.exposure = ' '
    expect(vault).not_to be_valid
  end

  it "user_id should be present" do
    vault.user_id = ' '
    expect(vault).not_to be_valid
  end

  it "should belongs to user" do
    user =  create(:user)
    vault.user_id = user.id
    expect(vault.user).to eq(user)
  end

  it "has many snippets" do
    create_list(:snippet, 2, vault_id: vault.id)
    expect(vault.snippets.size).to eq(2)
  end

  it "has 0 snippets when vault is deleted" do
    create_list(:snippet, 3, vault_id: vault.id)
    Vault.destroy(vault.id)
    expect(vault.snippets.size).to eq(0)
  end
end
