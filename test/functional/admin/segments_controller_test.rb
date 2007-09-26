require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/segments_controller'

# Re-raise errors caught by the controller.
class Admin::SegmentsController; def rescue_action(e) raise e end; end

class Admin::SegmentsControllerTest < Test::Unit::TestCase
  fixtures :admin_segments

  def setup
    @controller = Admin::SegmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_segments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_segment
    assert_difference('Admin::Segment.count') do
      post :create, :segment => { }
    end

    assert_redirected_to segment_path(assigns(:segment))
  end

  def test_should_show_segment
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_segment
    put :update, :id => 1, :segment => { }
    assert_redirected_to segment_path(assigns(:segment))
  end

  def test_should_destroy_segment
    assert_difference('Admin::Segment.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to admin_segments_path
  end
end
