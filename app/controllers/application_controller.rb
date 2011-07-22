class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
<<<<<<< HEAD
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
=======
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
>>>>>>> 269940add41ee18df983bbf99d80889df5b06e0d
end
