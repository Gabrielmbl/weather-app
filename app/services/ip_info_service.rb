require 'uri'
require 'net/http'
require 'json'


class IpInfoService
  def initialize(ip, format = 'json')
    @ip = ip
    @format = format
  end

  def info
    url = URI("https://ipapi.co/#{@ip}/json/")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = http.request(request)

    if response.code == '200'
      JSON.parse(response.body, symbolize_names: true)
    else
      { error: 'Failed to retrieve location information' }
    end
  end
end
