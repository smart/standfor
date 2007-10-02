require File.dirname(__FILE__) + '/../test_helper'
require 'sponsorships_controller'

# Re-raise errors caught by the controller.
class SponsorshipsController; def rescue_action(e) raise e end; end

class SponsorshipsControllerTest < Test::Unit::TestCase
  fixtures :sponsorships

  def setup
    @controller = SponsorshipsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsorships)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sponsorship
    assert_difference('Sponsorship.count') do
      post :create, :sponsorship => { }
    end

    assert_redirected_to sponsorship_path(assigns(:sponsorship))
  end

  def test_should_show_sponsorship
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_sponsorship
    put :update, :id => 1, :sponsorship => { }
    assert_redirected_to sponsorship_path(assigns(:sponsorship))
  end

  def test_should_destroy_sponsorship
    assert_difference('Sponsorship.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to sponsorships_path
  end
end
