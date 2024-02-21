# Location Model

class Location < ApplicationRecord
  validates :text_address, presence: true

  has_many :forecasts, dependent: :destroy

  def current_forecast(ipv6_address)
    weather_service = WeatherService.new(latitude(ipv6_address), longitude(ipv6_address))
    # weather_service.forecast
    # weather_service.parse_forecast(weather_service.forecast)
    weather_service.parse_forecast()

  end

  def latitude(ipv6_address)
    ip_info_service = IpInfoService.new(ipv6_address)
    ip_info = ip_info_service.info
    ip_info[:latitude]
  end

  def longitude(ipv6_address)
    ip_info_service = IpInfoService.new(ipv6_address)
    ip_info = ip_info_service.info
    ip_info[:longitude]
  end

end
