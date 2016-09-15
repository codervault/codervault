class SnippetsController < ApplicationController
  # Devise
  before_action :authenticate_user!, except: [:show]

  before_action :set_vault, only: [:show, :new, :create, :index]
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_permissions, only: [:new, :edit, :update, :destroy]
  before_action :check_show_permissions, only: [:show]
  before_action :redirect, only: [:index]

  # GET /snippets
  # GET /snippets.json
  def index
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @interaction_enabled = (user_signed_in? and @snippet.vault.user == current_user)
  end

  # GET /snippets/new
  def new
    @snippet = @vault.snippets.build
  end

  # GET /snippets/1/edit
  def edit
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = @vault.snippets.create(snippet_params)

    @snippet.vault_id = params[:vault_id]

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to [@snippet.vault, @snippet], notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to [@snippet.vault, @snippet], notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to @snippet.vault, notice: 'Snippet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_snippet
      @snippet = @vault.snippets.find_by_id(params[:id])
      redirect_to root_url if @snippet.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:name, :language, :code)
    end

    def check_edit_permissions
      if @vault.user_id != current_user.id then
        flash[:alert] = t(:permissions_error)
        redirect_to @vault
      end
    end

    def check_show_permissions
      if !user_signed_in? || @vault.user_id != current_user.id
        if @vault.exposure == "private_vault"
          flash[:alert] = t(:permissions_error)
          redirect_to @vault
        end
      end
    end

    def redirect
      redirect_to @vault
    end
end