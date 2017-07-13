class HomeController < ApplicationController
  def index
    @gyms = Gym.all

#  if params[:search].present?
#    @locations = Location.near(params[:search], 50, :order => :distance)
#  else
#    @locations = Location.all
#  end
  end

  def index_do
    @gyms = Gym.all
    form = params[:form]

#raise form[:search].inspect
  if form[:search].present?
    @locations = Location.near(form[:search], 50, :order => 'distance')
    @local = form[:search]
#    raise location.inspect
#    @locations << locat.near(form[:search], 20, :order => :distance)
  else
      @locations = Location.all#.nearbys(form[:search], :order => :distance)
  end

    #@locations = Location.near([@gyms.last.location.latitude, @gyms.last.location.longitude], 5, units: :km)
  end
end
