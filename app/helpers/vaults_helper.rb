module VaultsHelper
  def get_exposure_class(exposure)
    exposure_class = case exposure
      when "private_vault" then "danger"
      when "unlisted_vault" then "warning"
      when "public_vault" then "success"
      else "info"
    end
  end
end
