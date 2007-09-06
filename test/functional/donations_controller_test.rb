require File.dirname(__FILE__) + '/../test_helper'
require 'donations_controller'

# Re-raise errors caught by the controller.
class DonationsController; def rescue_action(e) raise e end; end

class DonationsControllerTest < Test::Unit::TestCase
  fixtures :donations

  def setup
    @controller = DonationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:donations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_donation
    assert_difference('Donation.count') do
      post :create, :donation => { }
    end

    assert_redirected_to donation_path(assigns(:donation))
  end

  def test_should_show_donation
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_donation
    put :update, :id => 1, :donation => { }
    assert_redirected_to donation_path(assigns(:donation))
  end

  def test_should_destroy_donation
    assert_difference('Donation.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to donations_path
  end
end
