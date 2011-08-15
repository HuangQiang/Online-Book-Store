class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    if params[:set_locale]
	  redirect_to store_path(:locale => params[:set_locale])
	else

      #@products =Product.all
	  @products = Product.paginate :page=>params[:page], :per_page =>5
	  @cart = current_cart

	  #数据库中获取产品
	  @products_sale = Product.find_by_sql('select * from products order by sale_num desc limit 5')

  end
 end
end
