class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]


  def validate_login
    if @online.eql? nil or @online.try(:kind).eql? 'client'
      flash[:error] = "Access denied"
      redirect_to :controller => '/home', :action => 'index'
    end
  end

  # GET /gyms
  # GET /gyms.json
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1
  # GET /gyms/1.json
  def show
  end

  # GET /gyms/new
  def new
    validate_login
    @gym = Gym.new
  end

  # GET /gyms/1/edit
  def edit
    validate_login
  end

  # POST /gyms
  # POST /gyms.json
  def create
    @location = Location.new
    @location.address = gym_params[:location]
    location = Location.limit(1).find_by_address(gym_params[:location])
    @location.save! if location.eql? nil
    location = Location.limit(1).find_by_address(gym_params[:location])
    @gym = Gym.new(gym_params.reject!{ |k| k == "location"})
#    raise @user.inspect
    @gym.location_id = location.id
 #   @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, notice: 'Gym was successfully created.' }
        format.json { render :show, status: :created, location: @gym }
        `echo "Nome:#{@gym.name}\n Gerente: #{@gym.manager.name}\n Address:#{@gym.location.address}" | mutt -s "Gym was successfully created." #{@gym.manager.email}`
      else
        format.html { render :new }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gyms/1
  # PATCH/PUT /gyms/1.json
  def update
    @location = Location.new
    @location.address = gym_params[:location]
    location = Location.limit(1).find_by_address(gym_params[:location])
    @location.save! if location.eql? nil
    location = Location.limit(1).find_by_address(gym_params[:location])

    respond_to do |format|
      if @gym.update(gym_params.reject!{ |k| k == "location"})
        @gym.location_id = location.id
        @gym.save!
        format.html { redirect_to @gym, notice: 'Gym was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym }
        `echo "Nome:#{@gym.name}\n Gerente: #{@gym.manager.name}\n Address:#{@gym.location.address}" | mutt -s "Gym was successfully updated." #{@gym.manager.email}`
      else
        format.html { render :edit }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gyms/1
  # DELETE /gyms/1.json
  def destroy
      `echo "Nome:#{@gym.name}\n Gerente: #{@gym.manager.name}\n Address:#{@gym.location.address}" | mutt -s "Gym was successfully destroyed." #{@gym.manager.email}`
    @gym.destroy
    respond_to do |format|
      format.html { redirect_to gyms_url, notice: 'Gym was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym
      @gym = Gym.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_params
      params.require(:gym).permit(:name, :location, :manager_id, :opening, :closing)
    end
end
