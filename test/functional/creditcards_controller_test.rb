require File.dirname(__FILE__) + '/../test_helper'
require 'creditcards_controller'

# Re-raise errors caught by the controller.
class CreditcardsController; def rescue_action(e) raise e end; end

class CreditcardsControllerTest < Test::Unit::TestCase
  fixtures :creditcards

  def setup
    @controller = CreditcardsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:creditcards)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_creditcard
    assert_difference('Creditcard.count') do
      post :create, :creditcard => { }
    end

    assert_redirected_to creditcard_path(assigns(:creditcard))
  end

  def test_should_show_creditcard
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_creditcard
    put :update, :id => 1, :creditcard => { }
    assert_redirected_to creditcard_path(assigns(:creditcard))
  end

  def test_should_destroy_creditcard
    assert_difference('Creditcard.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to creditcards_path
  end
end
