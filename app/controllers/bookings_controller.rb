class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy, :confirm, :reject]
  before_action :authorize_access, only: [:show, :update, :destroy, :confirm, :reject]

  def index
    if current_user.driver?
      @bookings = Booking.joins(:ride).where(rides: { driver_id: current_user.id }).order(created_at: :desc)
    else
      @bookings = current_user.bookings.order(created_at: :desc)
    end
  end

  def show
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'تم تحديث حالة الحجز بنجاح.'
    else
      render :show
    end
  end

  def destroy
    if current_user == @booking.user || current_user == @booking.ride.driver
      if @booking.update(status: :canceled)
        # إعادة المقاعد المتاحة إذا تم الإلغاء
        @booking.ride.update(available_seats: @booking.ride.available_seats + @booking.seats)
        redirect_to bookings_path, notice: 'تم إلغاء الحجز بنجاح.'
      else
        redirect_to bookings_path, alert: 'حدث خطأ أثناء إلغاء الحجز.'
      end
    else
      redirect_to bookings_path, alert: 'غير مصرح لك بإلغاء هذا الحجز.'
    end
  end

  def confirm
    if @booking.update(status: :confirmed)
      redirect_to bookings_path, notice: 'تم تأكيد الحجز بنجاح.'
    else
      redirect_to bookings_path, alert: 'حدث خطأ أثناء تأكيد الحجز.'
    end
  end

  def reject
    if @booking.update(status: :rejected)
      # إعادة المقاعد المتاحة
      @booking.ride.update(available_seats: @booking.ride.available_seats + @booking.seats)
      redirect_to bookings_path, notice: 'تم رفض الحجز بنجاح.'
    else
      redirect_to bookings_path, alert: 'حدث خطأ أثناء رفض الحجز.'
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(id: params[:id])

    if @booking.nil?
      redirect_to bookings_path, alert: 'الحجز غير موجود.'
      return
    end
  end

  def authorize_access
    unless current_user == @booking.user || (current_user.driver? && current_user == @booking.ride.driver)
      redirect_to bookings_path, alert: 'غير مصرح لك بالوصول إلى هذا الحجز.'
    end
  end

  def booking_params
    params.require(:booking).permit(:status)
  end
end
