# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :bookings]

  # GET /users/:id
  def show
    # Show user profile
  end

  # GET /users/:id/edit
  def edit
    # Edit user profile
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'تم تحديث الملف الشخصي بنجاح.'
    else
      render :edit
    end
  end

  # GET /users/:id/bookings
  def bookings
    if @user.driver?
      # If user is a driver, show bookings for their rides
      @bookings = Booking.joins(:ride).where(rides: { driver_id: @user.id }).order(created_at: :desc)
    else
      # If user is a passenger, show their bookings
      @bookings = @user.bookings.order(created_at: :desc)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :avatar, :driver)
  end
end
