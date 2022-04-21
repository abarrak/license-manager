class LicensesController < ApplicationController
  before_action :set_license, only: %i[ show edit update destroy ]

  # GET /licenses or /licenses.json
  def index
    @licenses = License.all
  end

  # GET /licenses/1 or /licenses/1.json
  def show
  end

  # GET /licenses/new
  def new
    @license = License.new
  end

  # GET /licenses/1/edit
  def edit
  end

  # POST /licenses or /licenses.json
  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to license_url(@license), notice: "License was successfully created." }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new, status: :unprocessable_entity, error: "An error occurred during license creation." }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1 or /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to license_url(@license), notice: "License was successfully updated." }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenses/1 or /licenses/1.json
  def destroy
    respond_to do |format|
      if @license.destroy
        flash[:notice] = "License was deleted successfully."
        format.html { redirect_to licenses_url }
        format.json { head :no_content }
      else
        flash[:error] = "Deleting license failed. Please try again."
        format.html { redirect_to licenses_url }
        format.json { head :no_content }
      end
    end
  end

  # GET /licenses/stats or /licenses/stats.json
  def stats
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_license
    @license = License.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def license_params
    params.require(:license).permit(:title, :current_expire_date, :renewal_times, :owner, :description)
  end
end
