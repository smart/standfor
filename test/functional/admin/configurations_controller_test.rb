require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/configurations_controller'

# Re-raise errors caught by the controller.
class Admin::ConfigurationsController; def rescue_action(e) raise e end; end

class Admin::ConfigurationsControllerTest < Test::Unit::TestCase
  fixtures :admin_configurations

  def setup
    @controller = Admin::ConfigurationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_configurations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_configuration
    assert_difference('Admin::Configuration.count') do
      post :create, :configuration => { }
    end

    assert_redirected_to configuration_path(assigns(:configuration))
  end

  def test_should_show_configuration
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_configuration
    put :update, :id => 1, :configuration => { }
    assert_redirected_to configuration_path(assigns(:configuration))
  end

  def test_should_destroy_configuration
    assert_difference('Admin::Configuration.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_configurations_path
  end
end
