class Forecast < ApplicationRecord
  belongs_to :location

    # TODO Need to have ip as a parameter here maybe. Depends if I can create create location objects with IP
  def self.create_forecasts(location_id)
    location = Location.find(location_id)
    weather_service = WeatherService.new(location.latitude(location.ip_address), location.longitude(location.ip_address))
    forecast_data = weather_service.parse_forecast()

    forecast_data[:forecast].each do |day|
      location.forecasts.create(date: Date.parse(day[:date]), high_temperature: day[:high], low_temperature: day[:low])
    end
  end

end
