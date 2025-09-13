# app/controllers/rides/bookings_controller.rb
class Rides::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ride
  before_action :ensure_passenger
  before_action :check_available_seats, only: [:create]

  def new
    @booking = @ride.bookings.build
  end

def create
  @booking = @ride.bookings.build(booking_params)
  @booking.user_id = current_user.id      # Set user_id
  @booking.passenger_id = current_user.id # Set passenger_id
  @booking.status = :pending

  if @booking.save
    @ride.update(available_seats: @ride.available_seats - @booking.seats)
    redirect_to ride_path(@ride), notice: 'تم طلب الحجز بنجاح، في انتظار موافقة السائق.'
  else
    render :new
  end
end

  private

  def set_ride
    @ride = Ride.find(params[:ride_id])
  end

  def ensure_passenger
    redirect_to @ride, alert: 'يجب أن تكون مسجلاً كراكب لحجز مقعد.' unless current_user.passenger?
  end

  def check_available_seats
    requested_seats = params[:booking][:seats].to_i
    if requested_seats > @ride.available_seats
      redirect_to new_ride_booking_path(@ride),
                  alert: "لا يوجد مقاعد كافية. المقاعد المتاحة: #{@ride.available_seats}"
    end
  end

  def booking_params
    params.require(:booking).permit(:seats, :notes)
  end
end
