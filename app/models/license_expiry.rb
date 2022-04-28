# == Schema Information
#
# Table name: license_expiries
#
#  id         :integer          not null, primary key
#  license_id :integer
#  days_count :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LicenseExpiry < ApplicationRecord
  belongs_to :license
  validates :days_count, presence: true, numericality: { only_integer: true, greater_than_or_equal: 0 }

  before_create :calculate_expiry

  def self.calculate_all_expiries!
    includes(:license).all.each do |record|
      record.calculate_expiry
      record.save
    end
  end

  def calculate_expiry
    calculator = ExpiryCalculator.new
    self[:days_count] = calculator.calculate self.license
  end
end
