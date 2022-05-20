module LicensesHelper

  def crud_enabled?
    Rails.application.config.allow_crud
  end
end
