class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    if user=User.authenticate(params[:name],params[:password])
      session[:user_id]=user.id
      session[:user_name]=user.name
      session[:user_type]=user.usertype
      redirect_to store_url
    else
      redirect_to login_url,:alert=>I18n.t('.alert')
    end
  end

  def destroy
    session[:user_id]=nil
    session[:user_name]=nil
    session[:user_type]=nil
    redirect_to store_url,:notice=>I18n.t('.logout_notice')
  end

end
