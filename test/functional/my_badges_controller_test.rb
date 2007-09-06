require File.dirname(__FILE__) + '/../test_helper'
require 'my_badges_controller'

# Re-raise errors caught by the controller.
class MyBadgesController; def rescue_action(e) raise e end; end

class MyBadgesControllerTest < Test::Unit::TestCase
  fixtures :my_badges

  def setup
    @controller = MyBadgesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:my_badges)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_my_badge
    assert_difference('MyBadge.count') do
      post :create, :my_badge => { }
    end

    assert_redirected_to my_badge_path(assigns(:my_badge))
  end

  def test_should_show_my_badge
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_my_badge
    put :update, :id => 1, :my_badge => { }
    assert_redirected_to my_badge_path(assigns(:my_badge))
  end

  def test_should_destroy_my_badge
    assert_difference('MyBadge.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to my_badges_path
  end
end
