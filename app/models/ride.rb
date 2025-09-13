# app/models/ride.rb
class Ride < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings, source: :user

  validates :origin, :destination, :departure_time, :available_seats, :price, presence: true
  validates :available_seats, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Remove these duplicate lines:
  # validates :origin, presence: true
  # validates :destination, presence: true

  scope :upcoming, -> { where('departure_time > ?', Time.current).order(departure_time: :asc) }
  scope :available, -> { where('available_seats > ?', 0) }
end
