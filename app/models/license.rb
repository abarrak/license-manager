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
  has_one :license_expiry
  has_rich_text :description
  validates_presence_of :title
end
