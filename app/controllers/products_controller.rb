class ProductsController < ApplicationController

 skip_before_filter :authorize, :only => [:show]

  # GET /products
  # GET /products.xml
  def index
    
    #@products = Product.all
	 @products = Product.paginate :page=>params[:page], :order=>'created_at desc', :per_page =>3
	
  end

  def search
	
	if(params[:search_string])
		#split key words
		@key_words=params[:search_string].split.uniq	
		@cart = current_cart;
		#search by each key word
		for key_word in @key_words do
			if @products
				@products = @products + Product.find_by_sql("select * from products where title like '%"+key_word+"%'")#+" or description like '%"+key_word+"%'")
			else
				@products = Product.find_by_sql("select * from products where title like '%"+key_word+"%'"+" or description like '%"+key_word+"%'")
			end
		end	
		
	end
	
	if @products
		@products.uniq!
	end
	 respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
	end
  end 

  
  

  # GET /products
  # GET /products.xml
 

  # GET /products/1
  # GET /products/1.xml
  def show

	@cart = current_cart;
    @product = Product.find(params[:id])
	#@comments = Comment.where(:product_id => @product.id)
	@comments = Comment.where(:product_id => @product.id).paginate :page=>params[:page], :order=>'created_at desc', :per_page =>5
	@comment = Comment.new
	

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

#feed format
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml { render :xml => @product }
    end
  end
  
  
  
  
  
  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
