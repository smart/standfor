require File.dirname(__FILE__) + '/../../test_helper'
require 'orgadmin/organizations_controller'

# Re-raise errors caught by the controller.
class Orgadmin::OrganizationsController; def rescue_action(e) raise e end; end

class Orgadmin::OrganizationsControllerTest < Test::Unit::TestCase
  fixtures :orgadmin_organizations

  def setup
    @controller = Orgadmin::OrganizationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:orgadmin_organizations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_organization
    assert_difference('Orgadmin::Organization.count') do
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
    assert_difference('Orgadmin::Organization.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to orgadmin_organizations_path
  end
end
