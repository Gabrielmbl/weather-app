class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # Find where I save text_address, to also save ip_address

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find(params[:id])
    @forecasts = @location.forecasts
    # @forecast = Forecast.find_by(location_id: params[:id])
  end

  # GET /locations/new
  def new
    @location = Location.new
    @forecast = @location.current_forecast(ipv6_address = request.remote_ip)
    @address = @location.text_address
    @location.ip_address = request.remote_ip
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    # TODO find out where is location_params coming from. I need to create a location object with IP address as well
    @location = Location.new(location_params)
    @location.ip_address = request.remote_ip

    respond_to do |format|
      if @location.save
        Forecast.create_forecasts(@location.id)
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
