require File.dirname(__FILE__) + '/../../test_helper'
require 'user/organizations_controller'

# Re-raise errors caught by the controller.
class User::OrganizationsController; def rescue_action(e) raise e end; end

class User::OrganizationsControllerTest < Test::Unit::TestCase
  fixtures :user_organizations

  def setup
    @controller = User::OrganizationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_organizations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_organization
    assert_difference('User::Organization.count') do
      post :create, :organization => { }
    end

    assert_redirected_to organization_path(assigns(:organization))
  end

  def test_should_show_organization
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_organization
    put :update, :id => 1, :organization => { }
    assert_redirected_to organization_path(assigns(:organization))
  end

  def test_should_destroy_organization
    assert_difference('User::Organization.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to user_organizations_path
  end
end
