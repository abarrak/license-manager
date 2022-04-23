# == Schema Information
#
# Table name: licenses
#
#  id                  :integer          not null, primary key
#  title               :string
#  current_expire_date :date
#  renewal_times       :integer
#  owner               :string
#  owner_email         :string
#  owner_mobile        :integer
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class License < ApplicationRecord
  include Scrapable

  has_one :license_expiry, dependent: :destroy
  has_rich_text :description

  validates_presence_of :title, :owner, :current_expire_date
  validates :title, length: { minimum: 2, maximum: 30 }, uniqueness: true
  validate :valid_expiry_date_format?

  private

  def valid_expiry_date_format?
    add_error = -> { errors.add :current_expire_date, "is of invalid type" }
    add_error.call unless self[:current_expire_date].is_a?(Date)
    add_error.call unless self[:current_expire_date]&.to_date
  rescue Date::Error
    add_error.call
  end
end
