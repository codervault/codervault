class SnippetsController < ApplicationController
  # Devise
  before_action :authenticate_user!, except: [:show]

  before_action :authenticate_username, only: [:show]
  before_action :set_vault
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_permissions, only: [:new, :edit, :update, :destroy]
  before_action :check_show_permissions, only: [:show]

  def show
    @interaction_enabled = (user_signed_in? and @snippet.vault.user == current_user)
  end

  def new
    @snippet = @vault.snippets.build
  end

  def edit
  end

  def create
    @snippet = @vault.snippets.build(snippet_params)

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to owner_vault_url(@vault, username: @vault.user_username), notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to owner_vault_url(@vault, username: @vault.user_username), notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to owner_vault_url(@vault, username: @vault.user_username), notice: 'Snippet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_snippet
      name = params[:id] ? params[:id] : params[:snippet_id]
      @snippet = @vault.find_snippet(name)
      redirect_to owner_vault_url(@vault, username: @vault.user_username) if @snippet.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:name, :language, :code)
    end
end