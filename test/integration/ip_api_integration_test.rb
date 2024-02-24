require 'test_helper'
require 'vcr'
require 'uri'

class IpApiIntegrationTest < ActionDispatch::IntegrationTest
  test 'should retrieve data from IP API' do
    VCR.use_cassette('ip_api_interaction') do
      ip_service = IpInfoService.new('8.8.8.8')
      ip_info = ip_service.info

      expected_data = {
        "ip" => "8.8.8.8",
        "network" => "8.8.8.0/24",
        "version" => "IPv4",
        "city" => "Mountain View",
        "region" => "California",
        "region_code" => "CA",
        "country" => "US",
        "country_name" => "United States",
        "country_code" => "US",
        "country_code_iso3" => "USA",
        "country_capital" => "Washington",
        "country_tld" => ".us",
        "continent_code" => "NA",
        "in_eu" => false,
        "postal" => "94043",
        "latitude" => 37.42301,
        "longitude" => -122.083352,
        "timezone" => "America/Los_Angeles",
        "utc_offset" => "-0800",
        "country_calling_code" => "+1",
        "currency" => "USD",
        "currency_name" => "Dollar",
        "languages" => "en-US,es-US,haw,fr",
        "country_area" => 9629091.0,
        "country_population" => 327167434,
        "asn" => "AS15169",
        "org" => "GOOGLE"
      }

      assert_equal expected_data.deep_symbolize_keys, ip_info
    end
  end
end
