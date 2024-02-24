# Location Model

class Location < ApplicationRecord
  validates :text_address, presence: false
  validates :ip_address, presence: true

  has_many :forecasts, dependent: :destroy

  def current_forecast(ip)
    weather_service = WeatherService.new(latitude(ip), longitude(ip))
    # weather_service.forecast
    # weather_service.parse_forecast(weather_service.forecast)
    weather_service.parse_forecast()

  end

  def latitude(ip)
    ip_info_service = IpInfoService.new(ip)
    ip_info = ip_info_service.info
    ip_info[:latitude]
  end

  def longitude(ip)
    ip_info_service = IpInfoService.new(ip)
    ip_info = ip_info_service.info
    ip_info[:longitude]
  end

end
