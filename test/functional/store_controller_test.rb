require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
<<<<<<< HEAD
    assert_select '#columns #side a',:minimum =>4
    assert_select '#main .entry',3
    assert_select 'h3','Programming Ruby 1.9'
=======
    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
>>>>>>> 269940add41ee18df983bbf99d80889df5b06e0d
    assert_select '.price',/\$[,\d]+\.\d\d/
  end

end
