class License < ApplicationRecord
  validates_presence_of :title
  has_rich_text :description
end
