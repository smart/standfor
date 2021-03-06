require File.dirname(__FILE__) + '/../../test_helper'
require 'orgadmin/campaigns_controller'

# Re-raise errors caught by the controller.
class Orgadmin::CampaignsController; def rescue_action(e) raise e end; end

class Orgadmin::CampaignsControllerTest < Test::Unit::TestCase
  fixtures :orgadmin_campaigns

  def setup
    @controller = Orgadmin::CampaignsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:orgadmin_campaigns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_campaign
    assert_difference('Orgadmin::Campaign.count') do
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
    assert_difference('Orgadmin::Campaign.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to orgadmin_campaigns_path
  end
end
