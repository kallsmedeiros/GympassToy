class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def validate_login
    if not @online.try(:kind).eql? 'gympass'
      flash[:error] = "Access denied"
      redirect_to :controller => '/home', :action => 'index'
    end
  end

  # GET /users
  # GET /users.json
  def index
    validate_login
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    validate_login
  end

  # POST /users
  # POST /users.json
  def create
    @work_location = Location.new
    @home_location = Location.new
    @work_location.address = user_params[:work_location]
    @home_location.address = user_params[:home_location]
    work = Location.limit(1).find_by_address(user_params[:work_location])
    home = Location.limit(1).find_by_address(user_params[:home_location])
    @work_location.save! if work.eql? nil
    @home_location.save! if home.eql? nil
    work = Location.limit(1).find_by_address(user_params[:work_location])
    home = Location.limit(1).find_by_address(user_params[:home_location])
    @user = User.new(user_params.reject!{ |k| k == "work_location" or k == "home_location"})
#    raise @user.inspect
    @user.work_location_id = work.id
    @user.home_location_id = home.id
    respond_to do |format|
      @user.password = Digest::MD5.hexdigest("#{@user.password}")
#      raise @user.inspect
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @work_location = Location.new
    @home_location = Location.new
    @work_location.address = user_params[:work_location]
    @home_location.address = user_params[:home_location]
    work = Location.limit(1).find_by_address(user_params[:work_location])
    home = Location.limit(1).find_by_address(user_params[:home_location])
    @work_location.save! if work.eql? nil
    @home_location.save! if home.eql? nil
    work = Location.limit(1).find_by_address(user_params[:work_location])
    home = Location.limit(1).find_by_address(user_params[:home_location])
    respond_to do |format|
      @user.password = Digest::MD5.hexdigest("#{@user.password}")
      if @user.update(user_params.reject!{ |k| k == "work_location" or k == "home_location"})
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :kind, :email, :password, :work_location, :home_location)
    end
end
