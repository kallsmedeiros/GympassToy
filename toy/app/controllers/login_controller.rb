class LoginController < ApplicationController
  require 'digest/md5'

  def index
  end

  def index_do
    form     = params[:form]
    password = Digest::MD5.hexdigest("#{form[:password]}") 
    user = User.find_by_email_and_password(form[:email], password)
    if not user.nil?
        session[:user_id] = user.id
        redirect_to :controller => '/home', :action => 'index'
    else
        flash[:error] = "user not found"
        redirect_to :controller => '/login', :action => 'index'
    end
  end
end
