require File.dirname(__FILE__) + '/../test_helper'
require 'badge_access_codes_controller'

# Re-raise errors caught by the controller.
class BadgeAccessCodesController; def rescue_action(e) raise e end; end

class BadgeAccessCodesControllerTest < Test::Unit::TestCase
  fixtures :badge_access_codes

  def setup
    @controller = BadgeAccessCodesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:badge_access_codes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_badge_access_code
    assert_difference('BadgeAccessCode.count') do
      post :create, :badge_access_code => { }
    end

    assert_redirected_to badge_access_code_path(assigns(:badge_access_code))
  end

  def test_should_show_badge_access_code
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_badge_access_code
    put :update, :id => 1, :badge_access_code => { }
    assert_redirected_to badge_access_code_path(assigns(:badge_access_code))
  end

  def test_should_destroy_badge_access_code
    assert_difference('BadgeAccessCode.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to badge_access_codes_path
  end
end
