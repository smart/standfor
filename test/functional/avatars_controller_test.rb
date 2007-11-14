require File.dirname(__FILE__) + '/../test_helper'
require 'avatars_controller'

# Re-raise errors caught by the controller.
class AvatarsController; def rescue_action(e) raise e end; end

class AvatarsControllerTest < Test::Unit::TestCase
  fixtures :avatars

  def setup
    @controller = AvatarsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:avatars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_avatar
    assert_difference('Avatar.count') do
      post :create, :avatar => { }
    end

    assert_redirected_to avatar_path(assigns(:avatar))
  end

  def test_should_show_avatar
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_avatar
    put :update, :id => 1, :avatar => { }
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  def test_should_destroy_avatar
    assert_difference('Avatar.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to avatars_path
  end
end
