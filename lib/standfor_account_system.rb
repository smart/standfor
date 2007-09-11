module StandforAccountSystem
   protected

    def badge_authorization_required
      store_location
      if account_required and  !@badge.authorized?(current_account)
        redirect_to(:controller => 'badges' , :action => :requirements, :id => @badge) and return false
      end
    end
=begin
   def account_required   
     current_account != :false  ? true : no_account
   end

   def current_account
     !session[:account].nil? ?  session[:account] :  :false
   end

   def no_account
     store_location
     redirect_to(:controller  => 'accounts', :action =>  'new') and return
   end

   def store_location
     session[:return_to] = request.request_uri
   end
    def redirect_back_or_default(default)
      session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
      session[:return_to] = nil
    end

   def self.included(base)
     base.send :helper_method, :current_account
   end
=end

    def payment_authorization_required(amount)
       session[:payment_return_to] = request.request_uri
       needs_authorization(amount) and return false if session[:authorization].nil? 
    end

    def needs_authorization(amount)
       redirect_to(:controller => 'authorizations', :action => 'new', :amount => amount) and return   	
    end

  
end