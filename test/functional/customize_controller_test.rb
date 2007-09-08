require File.dirname(__FILE__) + '/../test_helper'
require 'customize_controller'

# Re-raise errors caught by the controller.
class CustomizeController; def rescue_action(e) raise e end; end

class CustomizeControllerTest < Test::Unit::TestCase
  def setup
    @controller = CustomizeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
