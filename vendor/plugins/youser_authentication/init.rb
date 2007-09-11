require "rubygems"

VALID_AUTHENTICATORS = []

##OPENID REQUIRES
begin
  gem 'ruby-openid'
  require 'openid'
  VALID_AUTHENTICATORS << "OpenID"
rescue LoadError
  puts "Install the ruby-openid gem to enable OpenID support"
end

##FACEBOOK REQUIRES
begin
  require "rfacebook_on_rails/plugin/init"
  VALID_AUTHENTICATORS << "Facebook"
rescue Exception => e
  puts "There was a problem loading the RFacebook please check the plugin and the gem. visit http://rfacebook.rubyforge.org/ for help"
  #raise e
end

require 'acts_as_youser'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Youser)

#require File.dirname(__FILE__) + '/lib/tagging'
#require File.dirname(__FILE__) + '/lib/tag'