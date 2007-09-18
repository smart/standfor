# This plugin modifies the url_for behaviour in the following manner:
#
# url_for behaviour is the same except when the <tt>:subdomain</tt>
# is set. If it's set to a string, the string will be used as a
# subdomain for the normal domain name. The <tt>:tld_length</tt>
# option defines the length of the normal domain. This defaults to 1.
#
# Examples (normal domain is example.com):
#
# url_for(:subdomain => 'manfred') #=> ''
# url_for(:subdomain => 'manfred', :only_path => false) #=> 'http://manfred.example.com/'
# url_for(:subdomain => 'manfred', :only_path => false) #=> 'http://manfred.example.com/'
# url_for(:subdomain => false, :only_path => false) #=> 'http://example.com/'
#
# When the domain is 'example.co.uk'
#
# url_for(:subdomain => 'manfred', :only_path => false) #= 'http://manfred.co.uk'
# url_for(:subdomain => 'manfred', :tld_length => 2, :only_path => false)
#    #= 'http://manfred.example.co.uk'

module ActionController
  class UrlRewriter
    def rewrite(options = {})
      unless options[:subdomain].nil?
        if options[:subdomain] == false
          newhost = @request.domain(options[:tld_length] || 1)
        elsif @request.subdomains(options[:tld_length] || 1).first != options[:subdomain]
          newhost = "#{options[:subdomain]}." + @request.domain(options[:tld_length] || 1) 
        end
        unless newhost.nil?
          begin
            @request.host = newhost
            @request.host_with_port = "#{newhost}:#{@request.port}"
          rescue NoMethodError
            @request.env['HTTP_X_FORWARDED_HOST'] = "#{newhost}:#{@request.port}"
          end
        end
      end
      options.delete(:subdomain)
      options.delete(:tld_length)
      rewrite_url(rewrite_path(options), options)
    end
  end
end