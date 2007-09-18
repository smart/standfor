class SiteController < ApplicationController
   layout 'default'

    def setorg
       if request.host.match(/statndfor(\w+).org/)   
	  site_name = request.host.match(/statndfor(\w+).org/)[1]    
          @organization = Organization.find_by_site_name(site_name)
	  redirect_to :controller => 'organizations' , :action => 'show' , :organization => site_name
       end
    end

    def index
      if params[:organization].nil?
        redirect_to :controller => 'organizations', :action  => 'index'
      else
      redirect_to :controller =>'organizations', :action => 'show',:organization => params[:organization]
      end
      false
    end

   def login 
     session[:account] ||= Account.find(1)
     redirect_to session[:return_to]
   end

   def clear
     current_account.donations.each do |d| 
       d.destroy
     end

     current_account.my_badges.each do |mb|
       mb.destroy
     end

     redirect_to '/'
   end

end
