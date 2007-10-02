require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/organizationslogos_controller'

# Re-raise errors caught by the controller.
class Admin::OrganizationslogosController; def rescue_action(e) raise e end; end

class Admin::OrganizationslogosControllerTest < Test::Unit::TestCase
  fixtures :admin_organizationslogos

  def setup
    @controller = Admin::OrganizationslogosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_organizationslogos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_organizationslogo
    assert_difference('Admin::Organizationslogo.count') do
      post :create, :organizationslogo => { }
    end

    assert_redirected_to organizationslogo_path(assigns(:organizationslogo))
  end

  def test_should_show_organizationslogo
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_organizationslogo
    put :update, :id => 1, :organizationslogo => { }
    assert_redirected_to organizationslogo_path(assigns(:organizationslogo))
  end

  def test_should_destroy_organizationslogo
    assert_difference('Admin::Organizationslogo.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_organizationslogos_path
  end
end
