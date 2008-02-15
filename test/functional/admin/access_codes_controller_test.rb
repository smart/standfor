require File.dirname(__FILE__) + '/../../test_helper'

class Admin::AccessCodesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_access_codes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_access_code
    assert_difference('Admin::AccessCode.count') do
      post :create, :access_code => { }
    end

    assert_redirected_to access_code_path(assigns(:access_code))
  end

  def test_should_show_access_code
    get :show, :id => admin_access_codes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => admin_access_codes(:one).id
    assert_response :success
  end

  def test_should_update_access_code
    put :update, :id => admin_access_codes(:one).id, :access_code => { }
    assert_redirected_to access_code_path(assigns(:access_code))
  end

  def test_should_destroy_access_code
    assert_difference('Admin::AccessCode.count', -1) do
      delete :destroy, :id => admin_access_codes(:one).id
    end

    assert_redirected_to admin_access_codes_path
  end
end
