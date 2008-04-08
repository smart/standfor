require File.dirname(__FILE__) + '/../../test_helper'

class Admin::AccountsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_accounts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_account
    assert_difference('Admin::Account.count') do
      post :create, :account => { }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  def test_should_show_account
    get :show, :id => admin_accounts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => admin_accounts(:one).id
    assert_response :success
  end

  def test_should_update_account
    put :update, :id => admin_accounts(:one).id, :account => { }
    assert_redirected_to account_path(assigns(:account))
  end

  def test_should_destroy_account
    assert_difference('Admin::Account.count', -1) do
      delete :destroy, :id => admin_accounts(:one).id
    end

    assert_redirected_to admin_accounts_path
  end
end
