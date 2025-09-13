# app/models/user.rb
class User < ApplicationRecord
  enum role: { passenger: 0, driver: 1, admin: 2 }, _default: :passenger

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations for rides where user is the driver
  has_many :rides_as_driver, class_name: 'Ride', foreign_key: 'driver_id', dependent: :destroy

  # As a passenger - bookings where user is the passenger
  has_many :bookings, foreign_key: 'passenger_id', dependent: :destroy
  has_many :booked_rides, through: :bookings, source: :ride

  # Remove this duplicate line:
  # has_many :bookings, foreign_key: 'passenger_id', dependent: :destroy

  validates :name, :phone, presence: true

  def admin?
    role == 'admin' || (defined?(admin) && admin == true)
  end
end
