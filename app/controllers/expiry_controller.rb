class ExpiryController < ApplicationController
  def expired
    @records = find_records 0
    @page_title = 'Expired'
  end

  def expires_soon
    @records = find_records 1..29
    @page_title = 'Expiring Soon'
    render :expired
  end

  def stats
  end

  private

  def find_records filter
    License.includes(:license_expiry).where(license_expiry: { days_count: filter }).all
  end
end
