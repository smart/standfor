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

  def test_should_create_segments
    assert_difference('Segments.count') do
      post :create, :segments => { }
    end

    assert_redirected_to segments_path(assigns(:segments))
  end

  def test_should_show_segments
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_segments
    put :update, :id => 1, :segments => { }
    assert_redirected_to segments_path(assigns(:segments))
  end

  def test_should_destroy_segments
    assert_difference('Segments.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to segments_path
  end
end
