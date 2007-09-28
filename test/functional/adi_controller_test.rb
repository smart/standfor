require File.dirname(__FILE__) + '/../test_helper'
require 'adi_controller'

# Re-raise errors caught by the controller.
class AdiController; def rescue_action(e) raise e end; end

class AdiControllerTest < Test::Unit::TestCase
  def setup
    @controller = AdiController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
