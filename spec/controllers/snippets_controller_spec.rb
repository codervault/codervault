require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  let!(:not_current_user) { create(:user) }
  let!(:current_user) { create(:user) }
  let!(:snippet) { create(:snippet) }

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:set_snippet) }
  it { should use_before_action(:check_edit_permissions) }
  it { should use_before_action(:check_show_permissions) }

  describe "#show" do
    context "not logged in" do
      it "invalid username" do
        get :show, { vault_id: snippet.vault, snippet_id: snippet, username: "random" }
        expect(response).to redirect_to(root_path)
      end

      it "invalid vault" do
        get :show, { vault_id: 0, snippet_id: snippet, username: snippet.vault.user_username }
        expect(response).to redirect_to(root_path)
      end

      it "invalid snippet" do
        get :show, { vault_id: snippet.vault, snippet_id: 0, username: snippet.vault.user_username }
        expect(response).to redirect_to(owner_vault_path(snippet.vault, username: snippet.vault.user_username))
      end
    end

    context "logged in" do
      it "invalid username" do
        login_user(current_user)
        get :show, { vault_id: snippet.vault, snippet_id: snippet, username: 'random'}
        expect(response).to redirect_to(root_path)
      end

      it "invalid vault" do
        login_user(current_user)
        get :show, { vault_id: 0, snippet_id: snippet, username: snippet.vault.user_username }
        expect(response).to redirect_to(root_path)
      end

      it "invalid snippet" do
        login_user(current_user)
        get :show, { vault_id: snippet.vault, snippet_id: 0, username: snippet.vault.user_username }
        expect(response).to redirect_to(owner_vault_path(snippet.vault, username: snippet.vault.user_username))
      end
    end
  end

  describe "#edit" do
    it "not logged in" do
      get :edit, { vault_id: snippet.vault, id: snippet }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "not equal to current_user" do
      login_user(not_current_user)
      get :edit, { vault_id: snippet.vault, id: snippet, username: snippet.vault.user_username }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to be_present
    end

    it "logged in" do
      login_user(snippet.vault.user)
      get :edit, { vault_id: snippet.vault, id: snippet, username: snippet.vault.user_username }
      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    it "not logged in" do
      post :create, { vault_id: snippet.vault, snippet: attributes_for(:snippet, language: 'bash') }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(current_user)
      post :create, { vault_id: snippet.vault, snippet: attributes_for(:snippet, language: 'bash'), username: snippet.vault.user_username }
      expect(Snippet.count).to eq(2) # + 1 vault is created above
      expect(response).to redirect_to(owner_vault_path(snippet.vault, username: snippet.vault.user_username))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(current_user)
      post :create, { vault_id: snippet.vault, snippet: attributes_for(:snippet, name: ' ', language: 'bash'), username: snippet.vault.user_username }
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "not logged in" do
      put :update, { vault_id: snippet.vault, id: snippet }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "valid attributes" do
      login_user(snippet.vault.user)
      put :update, { vault_id: snippet.vault, id: snippet, snippet: attributes_for(:snippet, language: 'java'), username: snippet.vault.user_username }
      expect(response).to redirect_to(owner_vault_path(snippet.vault, username: snippet.vault.user_username))
      expect(flash[:notice]).to be_present
    end

    it "invalid attributes" do
      login_user(snippet.vault.user)
      put :update, { vault_id: snippet.vault, id: snippet, snippet: attributes_for(:snippet, code: ' ', language: 'java'), username: snippet.vault.user_username }
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    it "not logged in" do
      delete :destroy, { vault_id: snippet.vault, id: snippet }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "logged in" do
      login_user(snippet.vault.user)
      delete :destroy, { vault_id: snippet.vault, id: snippet, username: snippet.vault.user_username }
      expect(response).to redirect_to(owner_vault_path(snippet.vault, username: snippet.vault.user_username))
      expect(flash[:notice]).to be_present
    end
  end
end