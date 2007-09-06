require File.dirname(__FILE__) + '/../test_helper'
require 'requirements_controller'

# Re-raise errors caught by the controller.
class RequirementsController; def rescue_action(e) raise e end; end

class RequirementsControllerTest < Test::Unit::TestCase
  fixtures :requirements

  def setup
    @controller = RequirementsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:requirements)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_requirement
    assert_difference('Requirement.count') do
      post :create, :requirement => { }
    end

    assert_redirected_to requirement_path(assigns(:requirement))
  end

  def test_should_show_requirement
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_requirement
    put :update, :id => 1, :requirement => { }
    assert_redirected_to requirement_path(assigns(:requirement))
  end

  def test_should_destroy_requirement
    assert_difference('Requirement.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to requirements_path
  end
end
