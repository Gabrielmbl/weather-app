class Location < ApplicationRecord
  has_many :forecasts, dependent: :destroy
end
