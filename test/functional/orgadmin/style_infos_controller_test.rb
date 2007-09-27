require File.dirname(__FILE__) + '/../../test_helper'
require 'orgadmin/style_infos_controller'

# Re-raise errors caught by the controller.
class Orgadmin::StyleInfosController; def rescue_action(e) raise e end; end

class Orgadmin::StyleInfosControllerTest < Test::Unit::TestCase
  fixtures :orgadmin_style_infos

  def setup
    @controller = Orgadmin::StyleInfosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:orgadmin_style_infos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_style_info
    assert_difference('Orgadmin::StyleInfo.count') do
      post :create, :style_info => { }
    end

    assert_redirected_to style_info_path(assigns(:style_info))
  end

  def test_should_show_style_info
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_style_info
    put :update, :id => 1, :style_info => { }
    assert_redirected_to style_info_path(assigns(:style_info))
  end

  def test_should_destroy_style_info
    assert_difference('Orgadmin::StyleInfo.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to orgadmin_style_infos_path
  end
end
