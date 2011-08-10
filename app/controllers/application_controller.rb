class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  skip_before_filter :authorize
  protect_from_forgery
  
  private
    
	def current_cart
	  Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
	  cart = Cart.create
	  session[:cart_id] = cart.id
	  cart
	end
	
	protected
	
	  def authorize
	   if User.find_by_name(session[:user_name]) == nil
		   redirect_to login_url, :notice => "Please log in"
	  
		   #if session[:user_id].blank?
		   #@current_user = User.find_by_name(session[:user_name])
		   #redirect_to login_url, :notice => "Please log in"
		   #else
		    #redirect_to login_url, :notice => "Please log in"
			#@current_user = User.find_by_id(session[:user_id])
		end
	  end
	  
	  def set_i18n_locale_from_params
	    if params[:locale]
	      if I18n.available_locales.include?(params[:locale].to_sym)
	        I18n.locale = params[:locale]
	      else
	        flash.now[:notice] =
	          "#{params[:locale]} translation not available"
	        logger.error flash.now[:notice]
	       end
	     end
	   
	  end
	  
	  def default_url_options
	    {:locale => I18n.locale}
	    
	  end
end
