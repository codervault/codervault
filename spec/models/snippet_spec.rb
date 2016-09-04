require 'rails_helper'

RSpec.describe Snippet, type: :model do
  it { should belong_to(:vault) }
  it { should validate_presence_of(:name).on(:create) }
  it { should validate_presence_of(:language).on(:create) }
  it { should validate_presence_of(:code).on(:create) }
  it { should validate_presence_of(:vault_id).on(:create) }
  it { should define_enum_for(:language) }
end
