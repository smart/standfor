require File.dirname(__FILE__) + '/../../test_helper'
require 'user/my_badges_controller'

# Re-raise errors caught by the controller.
class User::MyBadgesController; def rescue_action(e) raise e end; end

class User::MyBadgesControllerTest < Test::Unit::TestCase
  fixtures :user_my_badges

  def setup
    @controller = User::MyBadgesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_my_badges)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_my_badge
    assert_difference('User::MyBadge.count') do
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
    assert_difference('User::MyBadge.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to user_my_badges_path
  end
end
