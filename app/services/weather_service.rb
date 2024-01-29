class WeatherService
  include HTTParty
  base_url 'https://api.open-meteo.com/v1'

  def initialize(latitude, longitude)
    @options = { query: {latitude: latitude, longitude: longitude, hourly: 'temperature_2m'} }
  end

  def forecast
    self.class.get('/forecast', @options)
  end
end
