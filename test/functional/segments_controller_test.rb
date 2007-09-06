require File.dirname(__FILE__) + '/../test_helper'
require 'segments_controller'

# Re-raise errors caught by the controller.
class SegmentsController; def rescue_action(e) raise e end; end

class SegmentsControllerTest < Test::Unit::TestCase
  fixtures :segments

  def setup
    @controller = SegmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:segments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_segment
    assert_difference('Segment.count') do
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
    assert_difference('Segment.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to segments_path
  end
end
