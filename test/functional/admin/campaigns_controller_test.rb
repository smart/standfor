require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/campaigns_controller'

# Re-raise errors caught by the controller.
class Admin::CampaignsController; def rescue_action(e) raise e end; end

class Admin::CampaignsControllerTest < Test::Unit::TestCase
  fixtures :admin_campaigns

  def setup
    @controller = Admin::CampaignsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_campaigns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_campaign
    assert_difference('Admin::Campaign.count') do
      post :create, :campaign => { }
    end

    assert_redirected_to campaign_path(assigns(:campaign))
  end

  def test_should_show_campaign
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_campaign
    put :update, :id => 1, :campaign => { }
    assert_redirected_to campaign_path(assigns(:campaign))
  end

  def test_should_destroy_campaign
    assert_difference('Admin::Campaign.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_campaigns_path
  end
end
