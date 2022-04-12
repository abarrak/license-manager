class LicenseExpiry < ApplicationRecord
  belongs_to :license
  validates :days_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
