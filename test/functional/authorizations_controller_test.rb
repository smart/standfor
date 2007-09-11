require File.dirname(__FILE__) + '/../test_helper'
require 'authorizations_controller'

# Re-raise errors caught by the controller.
class AuthorizationsController; def rescue_action(e) raise e end; end

class AuthorizationsControllerTest < Test::Unit::TestCase
  def setup
    @controller = AuthorizationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
