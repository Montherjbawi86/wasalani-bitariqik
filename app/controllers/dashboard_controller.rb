# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.driver?
      # إحصائيات السائق - استخدام rides_as_driver بدلاً من rides
      @rides = current_user.rides_as_driver.order(created_at: :desc)  # تغيير هنا
      @active_rides = @rides.upcoming
      @completed_rides = @rides.where('departure_time < ?', Time.now)
      @total_bookings = Booking.joins(:ride).where(rides: { driver_id: current_user.id })
      @confirmed_bookings = @total_bookings.confirmed
      @pending_bookings = @total_bookings.pending

      # الإيرادات
      @total_earnings = @confirmed_bookings.sum { |b| b.seats * b.ride.price }
      @potential_earnings = @pending_bookings.sum { |b| b.seats * b.ride.price }

      # الركاب
      @unique_passengers = @total_bookings.select('DISTINCT passenger_id').count

    else
      # إحصائيات الراكب
      @bookings = current_user.bookings.order(created_at: :desc)
      @upcoming_bookings = @bookings.joins(:ride).where('rides.departure_time > ?', Time.now)
      @completed_bookings = @bookings.joins(:ride).where('rides.departure_time < ?', Time.now)
      @total_spent = @completed_bookings.confirmed.sum { |b| b.seats * b.ride.price }

      # الرحلات
      @total_rides = @bookings.select('DISTINCT ride_id').count
      @cities_visited = @completed_bookings.joins(:ride).select('DISTINCT rides.to_city').count
    end
  end
end
