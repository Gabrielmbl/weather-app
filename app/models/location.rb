class Location < ApplicationRecord
  validates :ip_address, presence: true
  validates :text_address, presence: true

  has_many :forecasts, dependent: :destroy
end
