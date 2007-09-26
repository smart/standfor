require File.dirname(__FILE__) + '/../../test_helper'
require 'orgadmin/badges_controller'

# Re-raise errors caught by the controller.
class Orgadmin::BadgesController; def rescue_action(e) raise e end; end

class Orgadmin::BadgesControllerTest < Test::Unit::TestCase
  fixtures :orgadmin_badges

  def setup
    @controller = Orgadmin::BadgesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:orgadmin_badges)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_badge
    assert_difference('Orgadmin::Badge.count') do
      post :create, :badge => { }
    end

    assert_redirected_to badge_path(assigns(:badge))
  end

  def test_should_show_badge
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_badge
    put :update, :id => 1, :badge => { }
    assert_redirected_to badge_path(assigns(:badge))
  end

  def test_should_destroy_badge
    assert_difference('Orgadmin::Badge.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to orgadmin_badges_path
  end
end
