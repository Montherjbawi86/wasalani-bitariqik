# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def dashboard
    @users_count = User.count
    @rides_count = Ride.count
    respond_to do |format|
      format.html # This will render dashboard.html.erb
    end
  end

  def users
    @users = User.all
    respond_to do |format|
      format.html # This will render users.html.erb
    end
  end

  def rides
    @rides = Ride.all
    respond_to do |format|
      format.html # This will render rides.html.erb
    end
  end

  def bookings
    @bookings = Booking.all
    respond_to do |format|
      format.html # This will render bookings.html.erb
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
