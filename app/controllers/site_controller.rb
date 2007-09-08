class SiteController < ApplicationController
   layout 'default'

   def login 
     session[:account] ||= Account.find(1)
     redirect_to session[:return_to]
   end

end
