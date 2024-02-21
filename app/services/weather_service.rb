class WeatherService
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1'

  def initialize(latitude, longitude)
    @options = { query: {latitude: latitude, longitude: longitude, hourly: 'temperature_2m'} }
  end

  def forecast
    response = self.class.get('/forecast', @options)
    # puts "API Response: #{response}"
    response
  end


  # def parse_forecast(response)
  def parse_forecast()
    parsed_response = JSON.parse(forecast.body)

    if parsed_response['hourly'] && parsed_response['hourly']['temperature_2m']
      hourly_data = parsed_response['hourly']['temperature_2m'].each_slice(24).first(7)

      puts "hourly_data: #{hourly_data}"

      if hourly_data.is_a?(Array)
        forecast_data = hourly_data.map.with_index do |hourly_data, index|
          {
            date: parsed_response['hourly']['time'][index * 24].split('T').first,
            high: hourly_data.max,
            low: hourly_data.min,
          }
        end
        puts "forecast_data: #{forecast_data}"
        { forecast: forecast_data }
      else
        { error: 'Not enough hourly data available for forecast' }
      end
    else
      { error: 'Could not retrieve weather forecast' }
    end
  end

end
