require File.dirname(__FILE__) + '/../../test_helper'
require 'user/accounts_controller'

# Re-raise errors caught by the controller.
class User::AccountsController; def rescue_action(e) raise e end; end

class User::AccountsControllerTest < Test::Unit::TestCase
  fixtures :user_accounts

  def setup
    @controller = User::AccountsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_accounts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_account
    assert_difference('User::Account.count') do
      post :create, :account => { }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  def test_should_show_account
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_account
    put :update, :id => 1, :account => { }
    assert_redirected_to account_path(assigns(:account))
  end

  def test_should_destroy_account
    assert_difference('User::Account.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to user_accounts_path
  end
end
