module StandforAccountSystem
   protected

    def badge_authorization_required
      store_location
      if account_required and  !@badge.authorized?(current_account)
        redirect_to(:controller => 'badges' , :action => :requirements, :id => @badge) and return false
      end
    end


    def payment_authorization_required(amount, badge, segment )
       @authorization = badge.authorizations.find_by_badge_id_and_account_id(badge.id, current_account.id)
        if @authorization.nil?
          redirect_to(:controller => 'authorizations', :action => 'new', :amount => amount, 
		   :badge => badge, :segment => segment) and return false
	else
           return true	
        end
    end

  
end
