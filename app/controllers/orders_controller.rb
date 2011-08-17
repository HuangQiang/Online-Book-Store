class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  skip_before_filter :authorize,:only => [:new,:create]
  def index
#    @orders = Order.all
    @orders = Order.paginate :page=>params[:page], :order=>'created_at desc',:per_page =>10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    if current_cart.line_items.empty?
        redirect_to store_url,:notice => "Your cart is empty"
        return
    end

      if session[:user_type]==2 || session[:user_type]==1
        @order = Order.new
	  else 
	    redirect_to login_url,:notice => "please login before you buy"
    end

  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    
    #计数操作
    current_cart.line_items.each do |item|
      item.product.sale_num =0
      item.product.sale_num += item.quantity
      item.product.save
    end
    
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        
        Notifier.order_received(@order).deliver
        
        format.html { redirect_to(store_url, :notice => I18n.t('.thanks')) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end