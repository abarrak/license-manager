class OpsController < ApplicationController
  def dashboard
  end

  def clear
    Ops.clear_all
    redirect_to :dashboard, notice: "All licenses in the system are deleted successfully."
  end

  def sync
    Ops.sync_now
    redirect_to :dashboard, notice: "Syncing from exteranl source is triggered successfully."
  end
end
