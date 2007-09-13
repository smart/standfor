class SiteController < ApplicationController
   layout 'default'

   def login 
     session[:account] ||= Account.find(1)
     redirect_to session[:return_to]
   end

   def clear
     Donation.find_all_by_account_id().each do |d| 
       d.destroy
     end
     redirect_to '/'
   end

end
