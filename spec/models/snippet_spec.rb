require 'rails_helper'

RSpec.describe Snippet, type: :model do
  it { should belong_to(:vault) }
  it { should validate_presence_of(:name).on(:create) }
  it { should validate_presence_of(:language).on(:create) }
  it { should validate_presence_of(:code).on(:create) }
  it { should validate_presence_of(:vault_id).on(:create) }
  it { should define_enum_for(:language) }

  it "#to_param" do
    snippet = build_stubbed(:snippet, name: "Quick sort")
    expect(snippet.to_param).to eq("Quick-sort")
  end

  it "#format_name" do
    snippet = build_stubbed(:snippet, name: "   Quick sort    ")
    expect(snippet.format_name).to eq("Quick sort")
  end

  it "#find_snippet do" do
    snippet = create(:snippet)
    expect(snippet.vault.find_snippet(snippet.name)).to eq(snippet)
  end
end
