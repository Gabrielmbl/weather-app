class GeocodingService
  def initialize(address)
    @address = address
  end

  def geocode
    uri = URI("https://geocode.xyz/#{URI.encode(@address)}?json=1&auth=182754041308105193597x90166")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end