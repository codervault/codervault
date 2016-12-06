class VaultsController < ApplicationController
  # Devise
  before_action :authenticate_user!, except: [:show]

  before_action :set_vault, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_permissions, only: [:edit, :update, :destroy]
  before_action :check_show_permissions, only: :show

  def index
    @vaults = Vault.all.where(user_id: current_user.id).order("updated_at DESC")
  end

  def show
    @interaction_enabled = (user_signed_in? and @vault.user == current_user)
    @snippets = Snippet.all.where("vault_id = ?", @vault.id).order("updated_at DESC")
  end

  def new
    @vault = Vault.new
  end

  def edit
  end

  def create
    @vault = current_user.vaults.build(vault_params)

    respond_to do |format|
      if @vault.save
        format.html { redirect_to owner_vault_url(@vault, username: @vault.user_username), notice: 'Vault was successfully created.' }
        format.json { render :show, status: :created, location: @vault }
      else
        format.html { render :new }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vault.update(vault_params)
        format.html { redirect_to owner_vault_url(@vault, username: @vault.user_username), notice: 'Vault was successfully updated.' }
        format.json { render :show, status: :ok, location: @vault }
      else
        format.html { render :edit }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vault.destroy

    respond_to do |format|
      format.html { redirect_to vaults_url, notice: 'Vault was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def vault_params
      params.require(:vault).permit(:name, :readme, :exposure)
    end
end