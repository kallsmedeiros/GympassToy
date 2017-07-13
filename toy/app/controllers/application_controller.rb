class ApplicationController < ActionController::Base
   before_filter :load_user
   protect_from_forgery with: :exception
  def index
  end

  def load_user
    if session[:user_id]
      @online = User.find(session[:user_id])
    end
  end

  def logout
    reset_session
    redirect_to :controller => '/login', :action => 'index'
  end
end
