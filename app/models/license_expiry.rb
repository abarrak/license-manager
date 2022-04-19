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

  def self.calculate_all_expiries!
    calculator = ExpiryCalculator.new
    includes(:license).all.each do |record|
      record.days_count = calculator.calculate record.license
      record.save!
    end
  end
end
