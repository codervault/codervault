require 'rails_helper'

RSpec.describe VaultsController, type: :controller do

  let!(:not_current_user) { create(:user) }
  let!(:current_user) { create(:user) }
  let!(:vault) { create(:vault) }

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:set_vault) }
  it { should use_before_action(:check_edit_permissions) }
  it { should use_before_action(:check_show_permissions) }

  describe "#index" do
    it "not logged in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    context "not logged in" do
      it "invalid username" do
        get :show, vault_id: vault.name, username: ' '
        expect(response).to redirect_to(root_path)
      end
    end

    context "logged in" do
      it "invalid username" do
        login_user(vault.user)
        get :show, vault_id: vault.name, username: 'dasda1'
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#new" do
    it "not logged in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#edit" do
    it "not logged in" do
      get :edit, id: 'test'
      expect(response).to redirect_to(new_user_session_path)
    end

    it "not equal to current_user" do
      login_user(not_current_user)
      get :edit, id: vault.name
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to be_present
    end

    it "logged in" do
      login_user(vault.user)
      get :edit, id: vault.name
      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    it "not logged in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      post :create, vault: attributes_for(:vault, exposure: 'public_vault')
      expect(Vault.count).to eq(2) # +1 vault is created above
      expect(response).to redirect_to(owner_vault_path(assigns(:vault), username: assigns(:vault).user_username))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(current_user)
      post :create, vault: attributes_for(:vault, exposure: ' ')
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "not logged in" do
      put :update, id: vault.name
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(vault.user)
      put :update, id: vault.name, vault: attributes_for(:vault, exposure: 'public_vault')
      expect(response).to redirect_to(owner_vault_path(vault, username: vault.user_username))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(vault.user)
      put :update, id: vault.name, vault: attributes_for(:vault, exposure: ' ', name: ' ')
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "not logged in" do
      delete :destroy, id: vault.name
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(vault.user)
      delete :destroy, id: vault.name
      expect(response).to redirect_to(vaults_path)
      expect(flash[:notice]).to be_present
    end
  end
end