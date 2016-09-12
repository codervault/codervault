require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  it { should use_before_action(:authenticate_user!) }

  describe "#show" do
    it 'not logged in' do
      get :show, id: user.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'logged in' do
      login_user user
      get :show, id: user.id
      expect(response.status).to eq(200)
    end
  end
end