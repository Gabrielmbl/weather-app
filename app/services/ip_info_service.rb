require 'uri'
require 'net/http'
require 'json'

class IPInfoService
  def initialize(ip, format = 'json')
    @ip = ip
    @format = format
  end

  def get_info
    uri = URI.parse("https://ipapi.co/#{@ip}/#{@format}/")
    response = Net::HTTP.get(uri)
    puts "IP API Response: #{response}"
    JSON.parse(response)
  end
end
