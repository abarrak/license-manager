class OpsController < ApplicationController
  def dashboard
  end

  def clear
  end

  def sync
    Ops.sync_now
    redirect_to :dashboard, notice: "Syncing from exteranl source is triggered successfully."
  end
end
