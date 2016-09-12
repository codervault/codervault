require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  let!(:not_current_user) { create(:user) }
  let!(:current_user) { create(:user) }
  let!(:snippet) { create(:snippet) }

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:set_snippet) }
  it { should use_before_action(:check_edit_permissions) }
  it { should use_before_action(:check_show_permissions) }
  it { should use_before_action(:redirect) }

  describe "#index" do
    it "not logged in" do
      get :index, vault_id: snippet.vault.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      get :index, vault_id: snippet.vault.id
      expect(response).to redirect_to(vault_path(snippet.vault.id))
    end
  end

  describe "#show" do
    it "not logged in" do
      get :show, { vault_id: snippet.vault.id, id: snippet.id }
    end
  end

  describe "#edit" do
    it "not logged in" do
      get :edit, {vault_id: snippet.vault.id, id: snippet.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "not equal to current_user" do
      login_user(not_current_user)
      get :edit, {vault_id: snippet.vault.id, id: snippet.id}
      expect(response).to redirect_to(vault_path(snippet.vault.id))
      expect(flash[:alert]).to be_present
    end

    it "logged in" do
      login_user(snippet.vault.user)
      get :edit, {vault_id: snippet.vault.id, id: snippet.id}
      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    it "not logged in" do
      post :create, { vault_id: snippet.vault.id, snippet: attributes_for(:snippet, language: 'bash') }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      post :create, { vault_id: snippet.vault.id, snippet: attributes_for(:snippet, language: 'bash') }
      expect(Snippet.count).to eq(2) # + 1 vault is created above
      expect(response).to redirect_to(vault_snippet_path(vault_id: snippet.vault.id, id: assigns(:snippet).id))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(current_user)
      post :create, { vault_id: snippet.vault.id, snippet: attributes_for(:snippet, name: ' ', language: 'bash') }
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "not logged in" do
      put :update, { vault_id: snippet.vault.id, id: snippet.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "valid attributes" do
      login_user(snippet.vault.user)
      put :update, { vault_id: snippet.vault.id, id: snippet.id, snippet: attributes_for(:snippet, language: 'java') }
      expect(response).to redirect_to(vault_snippet_path(vault_id: snippet.vault.id, id: assigns(:snippet).id))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(snippet.vault.user)
      put :update, { vault_id: snippet.vault.id, id: snippet.id, snippet: attributes_for(:snippet, code: ' ', language: 'java') }
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    it "not logged in" do
      delete :destroy, { vault_id: snippet.vault.id, id: snippet.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(snippet.vault.user)
      delete :destroy, { vault_id: snippet.vault.id, id: snippet.id }
      expect(response).to redirect_to(vault_path(assigns(:vault)))
      expect(flash[:notice]).to be_present
    end
  end
end