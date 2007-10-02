require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/sponsorslogos_controller'

# Re-raise errors caught by the controller.
class Admin::SponsorslogosController; def rescue_action(e) raise e end; end

class Admin::SponsorslogosControllerTest < Test::Unit::TestCase
  fixtures :admin_sponsorslogos

  def setup
    @controller = Admin::SponsorslogosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sponsorslogos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sponsorslogo
    assert_difference('Admin::Sponsorslogo.count') do
      post :create, :sponsorslogo => { }
    end

    assert_redirected_to sponsorslogo_path(assigns(:sponsorslogo))
  end

  def test_should_show_sponsorslogo
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_sponsorslogo
    put :update, :id => 1, :sponsorslogo => { }
    assert_redirected_to sponsorslogo_path(assigns(:sponsorslogo))
  end

  def test_should_destroy_sponsorslogo
    assert_difference('Admin::Sponsorslogo.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_sponsorslogos_path
  end
end
