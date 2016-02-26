#@todo: secure by user?
class RidesController < ApplicationController
  #@todo: index scope only valid?
  def index
    @rides = Ride.all
  end

  def new
    @ride = Ride.new(ride_params)
  end

  def create
    @ride = Ride.create(ride_params)
    if @ride.valid?
      redirect_to rides_path, notice: 'Good news! Ride aproved!'
    else
      render :new, alert: @ride.errors.to_a
    end
  end
  #@todo: show only valid, map in view?
  def show
    @ride = Ride.find(params[:id])
  end
  #@todo make better query, add chartckick in view?
  def stats
    @rides = Ride.group_by_day(:rode_at)
  end
  
  private
  def ride_params
    params.fetch(:ride,{}).permit(:from,:to,:rode_at,:price,:provider_id)
  end
end
