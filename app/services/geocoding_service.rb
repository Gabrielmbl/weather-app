require 'uri'
require 'net/http'
require 'json'
require 'uri'

class GeocodingService
  def initialize(address)
    @address = address
  end

  def geocode
    uri = URI.parse("https://geocode.xyz/#{URI.encode_www_form_component(@address)}?json=1&auth=182754041308105193597x90166")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
