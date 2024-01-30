class WeatherService
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1'

  def initialize(latitude, longitude)
    @options = { query: {latitude: latitude, longitude: longitude, hourly: 'temperature_2m'} }
  end

  def forecast
    response = self.class.get('/forecast', @options)
    puts "API Response: #{response}"
    response
  end
end
