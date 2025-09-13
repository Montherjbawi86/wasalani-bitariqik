# app/controllers/rides_controller.rb
class RidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # GET /rides
  def index
    @rides = Ride.where('departure_time > ?', Time.current)
                 .order(departure_time: :asc)
  end

  # GET /rides/1
  def show
  end

  # GET /rides/new
  def new
    @ride = Ride.new
  end

  # GET /rides/1/edit
  def edit
  end

  # POST /rides
  def create
    @ride = current_user.rides_as_driver.new(ride_params)

    if @ride.save
      redirect_to @ride, notice: 'Ride was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rides/1
  def update
    if @ride.update(ride_params)
      redirect_to @ride, notice: 'Ride was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rides/1
  def destroy
    @ride.destroy
    redirect_to rides_url, notice: 'Ride was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ride_params
      params.require(:ride).permit(:origin, :destination, :from_city, :to_city,
                                  :departure_time, :available_seats, :price)
    end

    # Authorization check - only ride owner can edit/update/destroy
    def authorize_user
      unless @ride.driver == current_user
        redirect_to rides_path, alert: "You are not authorized to perform this action."
      end
    end
end
