class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.first(100)
  end

  def daytrips
    @trips = Trip.all
    @day_trips = @trips.group_by_day(:start_date).count
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new

  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params[:trip]
    end
end
