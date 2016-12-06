require 'rails_helper'

RSpec.describe Vault, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:snippets).dependent(:delete_all) }
  it { should validate_presence_of(:name).on(:create) }
  it { should validate_presence_of(:exposure).on(:create) }
  it { should validate_presence_of(:user_id).on(:create) }
  it { should define_enum_for(:exposure) }

  it "#to_param" do
    vault = build_stubbed(:vault, name: "Quick sort")
    expect(vault.to_param).to eq("Quick-sort")
  end

  it "#format_name" do
    vault = build_stubbed(:vault, name: "   Quick sort    ")
    expect(vault.format_name).to eq("Quick sort")
  end

  it "#find_snippet do" do
    snippet = create(:snippet)
    expect(snippet.vault.find_snippet(snippet.name)).to eq(snippet)
  end
end
