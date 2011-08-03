require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
	@update = {
		:title			=>	'Lorem Ipsum',
		:description	=>	'Wibbles are fun',
		:image_url		=> 	'lorem.jpg',
		:price			=>	19.95
	}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => @product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product.to_param
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product.to_param, :product => @update
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product.to_param
    end

    assert_redirected_to products_path
  end
  
	test "product is not valide without a nique title" do
		product = Product.new(:title => products(:ruby).title,
							:description => "yyy",
							:price => 1,
							:image_url => "fred.gif")
		assert !product.save
		assert_equal "has already been taken", product.errors[:title].join(';')
	end
	
end
