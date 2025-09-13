class HomeController < ApplicationController
  def index
    @rides = Ride.upcoming  # Use the scope instead of class method
  end

  def about
  end

  def contact
  end

  def how_it_works
  end
end
