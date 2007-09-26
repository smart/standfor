require File.dirname(__FILE__) + '/../abstract_unit'

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

module RequestForgeryProtectionTests
  def teardown
    ActionController::Base.request_forgery_protection_token = nil
  end
  
  def test_should_render_form_with_token_tag
    get :index
    assert_select 'form>div>input[name=?][value=?]', 'authenticity_token', @token
  end
  
  def test_should_render_button_to_with_token_tag
    get :show_button
    assert_select 'form>div>input[name=?][value=?]', 'authenticity_token', @token
  end

  def test_should_allow_get
    get :index
    assert_response :success
  end
  
  def test_should_allow_post_without_token_on_unsafe_action
    post :unsafe
    assert_response :success
  end
  
  def test_should_not_allow_post_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { post :index }
  end
  
  def test_should_not_allow_put_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { put :index }
  end
  
  def test_should_not_allow_delete_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { delete :index }
  end
  
  def test_should_not_allow_xhr_post_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { xhr :post, :index }
  end
  
  def test_should_not_allow_xhr_put_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { xhr :put, :index }
  end
  
  def test_should_not_allow_xhr_delete_without_token
    assert_raises(ActionController::InvalidAuthenticityToken) { xhr :delete, :index }
  end
  
  def test_should_allow_post_with_token
    post :index, :authenticity_token => @token
    assert_response :success
  end
  
  def test_should_allow_put_with_token
    put :index, :authenticity_token => @token
    assert_response :success
  end
  
  def test_should_allow_delete_with_token
    delete :index, :authenticity_token => @token
    assert_response :success
  end
  
  def test_should_allow_post_with_xml
    post :index, :format => 'xml'
    assert_response :success
  end
  
  def test_should_allow_put_with_xml
    put :index, :format => 'xml'
    assert_response :success
  end
  
  def test_should_allow_delete_with_xml
    delete :index, :format => 'xml'
    assert_response :success
  end
end

module RequestForgeryProtectionActions
  def index
    render :inline => "<%= form_tag('/') {} %>"
  end
  
  def show_button
    render :inline => "<%= button_to('New', '/') {} %>"
  end
  
  def unsafe
    render :text => 'pwn'
  end
  
  def rescue_action(e) raise e end
end

class RequestForgeryProtectionController < ActionController::Base
  include RequestForgeryProtectionActions
  protect_from_forgery :only => :index, :secret => 'abc'
end

class RequestForgeryProtectionControllerTest < Test::Unit::TestCase
  include RequestForgeryProtectionTests
  def setup
    @controller = RequestForgeryProtectionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    class << @request.session
      def session_id() '123' end
    end
    @token = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('SHA1'), 'abc', '123')
    ActionController::Base.request_forgery_protection_token = :authenticity_token
  end
end

# no token is given, assume the cookie store is used
class CsrfCookieMonsterController < ActionController::Base
  include RequestForgeryProtectionActions
  protect_from_forgery :only => :index
end

class FakeSessionDbMan
  def self.generate_digest(data)
    Digest::SHA1.hexdigest("secure")
  end
end

class CsrfCookieMonsterControllerTest < Test::Unit::TestCase
  include RequestForgeryProtectionTests
  def setup
    @controller = CsrfCookieMonsterController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    # simulate a cookie session store
    @request.session.instance_variable_set(:@dbman, FakeSessionDbMan)
    class << @request.session
      attr_reader :dbman
    end
    @token = Digest::SHA1.hexdigest("secure")
    ActionController::Base.request_forgery_protection_token = :authenticity_token
  end
end

