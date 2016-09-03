require 'rails_helper'

RSpec.describe Snippet, type: :model do

  let(:snippet) { create(:snippet) }

  it "name should be present" do
    snippet.name = ' '
    expect(snippet).not_to be_valid
  end

  it "language should be present" do
    snippet.language = ' '
    expect(snippet).not_to be_valid
  end

  it "code should be present" do
    snippet.code = ' '
    expect(snippet).not_to be_valid
  end

  it "vault_id should be present" do
    snippet.vault_id = ' '
    expect(snippet).not_to be_valid
  end

  it "belongs to vault" do
    vault = create(:vault)
    snippet.vault_id = vault.id
    expect(snippet.vault).to eq(vault)
  end
end