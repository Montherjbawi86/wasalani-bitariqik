class Booking < ApplicationRecord
  belongs_to :user    # Change to user instead of passenger
  belongs_to :ride

  enum status: { pending: 0, confirmed: 1, canceled: 2, rejected: 3 }

  validates :seats, numericality: { only_integer: true, greater_than: 0 }
  validate :available_seats
  validate :user_cannot_be_driver  # Rename this method

  private

  def available_seats
    if seats && ride && seats > ride.available_seats
      errors.add(:seats, "لا يوجد مقاعد كافية متاحة")
    end
  end

  def user_cannot_be_driver  # Renamed method
    if user == ride.driver
      errors.add(:base, "لا يمكن للسائق حجز مقعد في رحلته الخاصة")
    end
  end
end
