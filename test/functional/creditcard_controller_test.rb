require File.dirname(__FILE__) + '/../test_helper'
require 'creditcard_controller'

# Re-raise errors caught by the controller.
class CreditcardController; def rescue_action(e) raise e end; end

class CreditcardControllerTest < Test::Unit::TestCase
  def setup
    @controller = CreditcardController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
