class WeatherService
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1'

  def initialize(latitude, longitude)
    @options = { query: { latitude: latitude, longitude: longitude, daily: 'temperature_2m_max,temperature_2m_min', temperature_unit: 'fahrenheit' } }
  end

  def forecast
    response = self.class.get('/forecast', @options)
    puts "API Response Code: #{response.code}"
    puts "API Response: #{response.body}"
    response
  end

  def parse_forecast
    parsed_response = JSON.parse(forecast.body)

    if parsed_response['daily'] && parsed_response['daily']['time']
      daily_data = parsed_response['daily']['time'].zip(parsed_response['daily']['temperature_2m_max'], parsed_response['daily']['temperature_2m_min'])
      forecast_data = daily_data.map do |date, max_temp, min_temp|
        {
          date: date,
          high: max_temp,
          low: min_temp
        }
      end

      puts "Forecast Data: #{forecast_data}"

      { forecast: forecast_data }
    else
      # { error: 'Could not retrieve weather forecast' }
      { forecast: [] }
    end
  end

  # rescue JSON::ParserError => e
  #   puts "Error parsing JSON: #{e.message}"
  #   { error: 'Error parsing JSON response' }
  # end

end
