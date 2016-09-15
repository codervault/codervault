class VaultsController < ApplicationController
  # Devise
  before_action :authenticate_user!, except: [:show]

  before_action :set_vault, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_permissions, only: [:edit, :update, :destroy]
  before_action :check_show_permissions, only: :show

  def check_edit_permissions
    if @vault.user_id != current_user.id then
      flash[:alert] = t(:permissions_error)
      redirect_to root_path
    end
  end

  def check_show_permissions
    if !user_signed_in? || @vault.user_id != current_user.id
      if @vault.exposure == "private_vault"
        flash[:alert] = t(:permissions_error)
        redirect_to root_path
      end
    end
  end

  # GET /vaults
  # GET /vaults.json
  def index
    @vaults = Vault.all.where(user_id: current_user.id).order("updated_at DESC")
  end

  # GET /vaults/1
  # GET /vaults/1.json
  def show
    @interaction_enabled = (user_signed_in? and @vault.user == current_user)
    @snippets = Snippet.all.where("vault_id = ?", @vault.id).order("updated_at DESC")
  end

  # GET /vaults/new
  def new
    @vault = Vault.new
  end

  # GET /vaults/1/edit
  def edit
    @vault.user_id == current_user
  end

  # POST /vaults
  # POST /vaults.json
  def create
    @vault = Vault.new(vault_params)

    @vault.user_id = current_user.id

    respond_to do |format|
      if @vault.save
        format.html { redirect_to @vault, notice: 'Vault was successfully created.' }
        format.json { render :show, status: :created, location: @vault }
      else
        format.html { render :new }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vaults/1
  # PATCH/PUT /vaults/1.json
  def update
    respond_to do |format|
      if @vault.update(vault_params)
        format.html { redirect_to @vault, notice: 'Vault was successfully updated.' }
        format.json { render :show, status: :ok, location: @vault }
      else
        format.html { render :edit }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaults/1
  # DELETE /vaults/1.json
  def destroy
    @vault.destroy

    respond_to do |format|
      format.html { redirect_to vaults_url, notice: 'Vault was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vault
      @vault = Vault.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vault_params
      params.require(:vault).permit(:name, :readme, :exposure)
    end
end
