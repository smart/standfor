require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/sponsors_controller'

# Re-raise errors caught by the controller.
class Admin::SponsorsController; def rescue_action(e) raise e end; end

class Admin::SponsorsControllerTest < Test::Unit::TestCase
  fixtures :admin_sponsors

  def setup
    @controller = Admin::SponsorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sponsors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sponsor
    assert_difference('Admin::Sponsor.count') do
      post :create, :sponsor => { }
    end

    assert_redirected_to sponsor_path(assigns(:sponsor))
  end

  def test_should_show_sponsor
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_sponsor
    put :update, :id => 1, :sponsor => { }
    assert_redirected_to sponsor_path(assigns(:sponsor))
  end

  def test_should_destroy_sponsor
    assert_difference('Admin::Sponsor.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_sponsors_path
  end
end
