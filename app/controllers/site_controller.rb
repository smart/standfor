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
        get_featured_badges
        render :template => '/site/index'
      else
      redirect_to :controller =>'organizations', :action => 'show', :organization => params[:organization]
      end
      false
    end

    def leaderboard
    end

    def badges 
    end

    def sponsors
    end


   # These actions are for development purposes, it can probably be deleted  
   def _login 
     session[:account] ||= Account.find(1)
     redirect_to session[:return_to]
   end

   def _clear
       current_account.donations.each do |d| 
         d.destroy
       end
      current_account.my_badges.each do |mb|
        mb.destroy
      end
      self.current_account.forget_me if logged_in?
      cookies.delete :auth_token
      reset_session
     redirect_to '/'
   end
  
   private

   def get_featured_badges
     @badges = Badge.find(:all, :limit => 6 )
   end

end
