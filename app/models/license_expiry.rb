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
  validates :days_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
