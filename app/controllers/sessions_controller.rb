class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
	  session[:user_name] = user.name
	  redirect_to admin_url
	else
	  redirect_to login_url, :alert => "Invalid user/password combination"
	end
  end


  def destroy
    session[:user_name] = nil
	redirect_to store_url, :notice => 'Logged out'
  end

end
