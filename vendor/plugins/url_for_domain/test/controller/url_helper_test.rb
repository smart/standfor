$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'rubygems'
require 'test/unit'

require 'action_controller'
require 'action_controller/test_process'

ActionController::Base.logger = nil
ActionController::Base.ignore_missing_templates = false
ActionController::Routing::Routes.reload rescue nil

require 'action_view'

require File.dirname(__FILE__) + '/../../init'

class DomainUrlHelperTest < Test::Unit::TestCase
  def setup
    @request = ActionController::TestRequest.new
    @params = {}
    @rewriter = ActionController::UrlRewriter.new(@request, @params)
    @params[:controller] = 'comment'
    @params[:action] = 'me'
    @params[:id] = '2'
  end
  
  def test_with_subdomain
    assert_equal "http://example.test.host/comment/me/2", @rewriter.rewrite(:subdomain =>  'example',
      :only_path => false, :overwrite_params => {})
  end
  
  def test_with_subdomain_and_tld_length
    @request.host = 'example.com'
    assert_equal "http://example.example.com/comment/me/2", @rewriter.rewrite(:subdomain => 'example',
      :tld_length => 1, :only_path => false, :overwrite_params => {})
  end
  
  def test_with_subdomain_and_tld_length_and_subdomain_in_place
    @request.host = 'example.example.com'
    assert_equal "http://example.example.com/comment/me/2", @rewriter.rewrite(:subdomain => 'example',
      :tld_length => 1, :only_path => false, :overwrite_params => {})
  end
  
  def test_with_subdomain_and_tld_length_and_subdomain_in_place_to_another_subdomain
    @request.host = 'example.example.com'
    assert_equal "http://example2.example.com/comment/me/2", @rewriter.rewrite(:subdomain => 'example2',
      :tld_length => 1, :only_path => false, :overwrite_params => {})
  end
  
  def test_without_subdomain
    assert_equal "http://test.host/comment/me/2", @rewriter.rewrite(:only_path => false,
      :overwrite_params => {})
  end
  
  def test_without_path
    assert_equal "/comment/me/2", @rewriter.rewrite(:only_path => true, :overwrite_params => {})
  end
  
  def test_with_subdomain_false
    @request.host = 'subdomain.example.com'
    assert_equal "http://example.com/comment/me/2", @rewriter.rewrite(:subdomain => false,
      :tld_length => 1, :only_path => false, :overwrite_params => {})
  end
  
  def test_with_subdomain_false_only_path
    @request.host = 'subdomain.example.com'
    assert_equal "/comment/me/2", @rewriter.rewrite(:subdomain => false,
      :tld_length => 1, :only_path => true, :overwrite_params => {})
  end
end