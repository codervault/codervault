class HomeController < ApplicationController
  def index
    @public_vaults = Vault.where(exposure: 2)
    @public_vaults_by_name = @public_vaults.order(name: :ASC)
    @public_vaults_by_updated_at = @public_vaults.order(updated_at: :DESC)
  end

  def about
  end
end
