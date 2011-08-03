class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		if 	cart = Cart.first
		else 
			cart = Cart.create
		end
		session[:cart_id] = cart.id
		cart
	end
end
