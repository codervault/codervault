require 'rails_helper'

RSpec.describe VaultsController, type: :controller do

  let!(:not_current_user) { create(:user) }
  let!(:current_user) { create(:user) }
  let!(:vault) { create(:vault) }

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:set_vault) }
  it { should use_before_action(:check_edit_permissions) }
  it { should use_before_action(:check_show_permissions) }

  describe "GET #index" do
    it "should redirect users to login_path if not log in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should render :index when user is logged_in" do
      login_user(current_user)
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "should render :show even user is not log in" do
      get :show, id: vault.id
    end
  end

  describe "GET #new" do
    it "should redirect users to login_path if not log in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should render :new when user is logged_in" do
      login_user(current_user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "should redirect users to login_path if not log in" do
      get :edit, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect user to root_path if vault's user id != current_user id" do
      login_user(not_current_user)
      get :edit, id: vault.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to be_present
    end

    it "should render :edit when user is logged_in" do
      login_user(vault.user)
      get :edit, id: vault.id
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "should redirect users to login_path if not log in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should :create vault when user is logged_in" do
      login_user(current_user)
      post :create, vault: attributes_for(:vault, exposure: 'public_vault')
      expect(Vault.count).to eq(2) # + 1 vault is created above
      expect(response).to redirect_to(vault_path(assigns(:vault).id))
      expect(flash[:notice]).to be_present
    end

    it "should render :new if vault attributes is invalid" do
      login_user(current_user)
      post :create, vault: attributes_for(:vault, exposure: ' ')
      expect(response).to render_template(:new)
    end
  end

  describe "PUT #update" do
    it "should redirect users to login_path if not log in" do
      put :update, id: vault.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should :update vault when user is logged_in" do
      login_user(vault.user)
      put :update, id: vault.id, vault: attributes_for(:vault, exposure: 'public_vault')
      expect(response).to redirect_to(vault_path(assigns(:vault).id))
      expect(flash[:notice]).to be_present
    end

    it "should render :edit if vault attributes is invalid" do
      login_user(vault.user)
      put :update, id: vault.id, vault: attributes_for(:vault, exposure: ' ')
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "should redirect users to login_path if not log in" do
      delete :destroy, id: vault.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should :delete vault when user is logged_in" do
      login_user(vault.user)
      delete :destroy, id: vault.id
      expect(response).to redirect_to(vaults_path)
      expect(flash[:notice]).to be_present
    end
  end
end
