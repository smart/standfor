require File.dirname(__FILE__) + '/../../test_helper'
require 'user/orders_controller'

# Re-raise errors caught by the controller.
class User::OrdersController; def rescue_action(e) raise e end; end

class User::OrdersControllerTest < Test::Unit::TestCase
  fixtures :user_orders

  def setup
    @controller = User::OrdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_orders)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_order
    assert_difference('User::Order.count') do
      post :create, :order => { }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  def test_should_show_order
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_order
    put :update, :id => 1, :order => { }
    assert_redirected_to order_path(assigns(:order))
  end

  def test_should_destroy_order
    assert_difference('User::Order.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to user_orders_path
  end
end
