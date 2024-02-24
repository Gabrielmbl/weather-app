require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @location = locations(:one)
  end

  test "visiting the index" do
    visit locations_url
    assert_selector "h1", text: "Locations"
  end

  test "should create location" do
    visit locations_url
    click_on "New location"

    fill_in "Ip address", with: @location.ip_address
    fill_in "Text address", with: @location.text_address
    click_on "Create Location"

    assert_text "Location was successfully created"
    click_on "Back"
  end

  test "should update Location" do
    visit location_url(@location)
    click_on "Edit this location", match: :first

    fill_in "Ip address", with: @location.ip_address
    fill_in "Text address", with: @location.text_address
    click_on "Update Location"

    assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "should destroy Location" do
    visit location_url(@location)
    click_on "Destroy this location", match: :first

    assert_text "Location was successfully destroyed"
  end

  # test "visiting the show page" do
  #   location = locations(:one)

  #   visit location_path(location)

  #   assert_text "Location Details"
  #   assert_text "Address: #{location.text_address}"
  #   assert_text "IP Address: #{location.ip_address}"
  #   assert_selector "table#forecasts_table"
  #   assert_selector "table#forecasts_table tr", count: location.forecasts.count
  #   location.forecasts.each do |forecast|
  #     assert_selector "table#forecasts_table", text: forecast.date.to_s
  #     assert_selector "table#forecasts_table", text: forecast.high_temperature.to_s
  #     assert_selector "table#forecasts_table", text: forecast.low_temperature.to_s
  #   end
  # end
end
