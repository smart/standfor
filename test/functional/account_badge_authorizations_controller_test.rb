require File.dirname(__FILE__) + '/../test_helper'
require 'account_badge_authorizations_controller'

# Re-raise errors caught by the controller.
class AccountBadgeAuthorizationsController; def rescue_action(e) raise e end; end

class AccountBadgeAuthorizationsControllerTest < Test::Unit::TestCase
  fixtures :account_badge_authorizations

  def setup
    @controller = AccountBadgeAuthorizationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:account_badge_authorizations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_account_badge_authorization
    assert_difference('AccountBadgeAuthorization.count') do
      post :create, :account_badge_authorization => { }
    end

    assert_redirected_to account_badge_authorization_path(assigns(:account_badge_authorization))
  end

  def test_should_show_account_badge_authorization
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_account_badge_authorization
    put :update, :id => 1, :account_badge_authorization => { }
    assert_redirected_to account_badge_authorization_path(assigns(:account_badge_authorization))
  end

  def test_should_destroy_account_badge_authorization
    assert_difference('AccountBadgeAuthorization.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to account_badge_authorizations_path
  end
end
