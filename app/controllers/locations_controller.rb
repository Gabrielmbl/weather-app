class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    latitude = 52.52
    longitude = 13.41

    weather_service = WeatherService.new(latitude, longitude)
    @forecast = weather_service.forecast

    if @forecast && @forecast['hourly'] && @forecast['hourly']['temperature_2m']
      # Group temperature data by day
      daily_temperatures = @forecast['hourly']['temperature_2m'].each_slice(24).to_a

      # Calculate max and min temperature for each day
      @daily_max_temps = daily_temperatures.map { |day_temps| day_temps.compact.max }
      @daily_min_temps = daily_temperatures.map { |day_temps| day_temps.compact.min }

      # Extract date for each day
      @daily_dates = daily_temperatures.map { |day_temps| day_temps.first['timestamp'] }

      # Assign necessary data to variables for the view
      @daily_temperatures = daily_temperatures
    else
      # Handle the case where the forecast data is not as expected
      flash[:alert] = "Error fetching weather forecast."
      @daily_temperatures = []  # Set to an empty array to avoid nil error in the view
      @daily_max_temps = []
      @daily_min_temps = []
      @daily_dates = []
    end
  end


  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:ip_address, :text_address)
    end
end
