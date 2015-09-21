class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @first_trip = Trip.first()
    @last_trip = Trip.last()
    # @trips = Trip.includes(:departing_station).first(10)
    # @sf = @trips.select{|trip| trip.departing_station.landmark ==  "San Francisco"}
  end

  def test
    @trips = Trip.includes(:departing_station).limit(20)
    # @sf = Trip.joins('INNER JOIN stations ON trips.departing_station_id = stations.id').limit(40)
    @sf = @trips.select{|trip| trip.departing_station.landmark ==  "San Francisco"}
    # @total = @sf.group_by_day(:departing_date).count
    # @sf = Trip.joins('INNER JOIN stations ON trips.departing_station_id = stations.id').where('landmark' = "San Francisco").limit(10)
    # @sf = Trip.joins(:departing_station).where( departing_station: { landmark: "San Francisco" } ).limit(10)
    # @sf = Trip.includes(:departing_station).select{|trip| trip.departing_station.landmark ==  "San Francisco"}.limit(40)
    # @total_trips = @trips.group_by_day(:departing_date).count
    # @sf_trips = @sf.group_by_day(:departing_date).count
    # @total_trips = @trips.where('departing_station.landmark = "San Francisco"').group_by_day(:departing_date).count
  end

  def daytrips
    # @trips = Trip.includes(:departing_station, :departing_date).all
    @trips = Trip.includes(:departing_station).all
    @sf = @trips.select{|trip| trip.departing_station.landmark ==  "San Francisco"}
    @total_trips = @trips.group_by_day(:departing_date).count
    @sf_trips = @sf.count
    # @customer_trips = @trips.group_by_day(:departing_date).where(subscriber_type: "Customer").count
    # @subscriber_trips = @trips.group_by_day(:departing_date).where(subscriber_type: "Subscriber").count
  end

  def show
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
