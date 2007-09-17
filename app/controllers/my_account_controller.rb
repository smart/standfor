class MyAccountController < ApplicationController
   layout 'default'
   before_filter :login_required

   def index
    @account = Account.find(current_account.id)
   end

   def edit
    @account = Account.find(current_account.id)
     render :action => 'edit.rjs' 
   end

   def update
     @account = Account.find(current_account.id)
     if @account.update_attributes(params[:my_account])
       session[:account] = @account
       render :action => 'update.rjs' 
     end
   end

end
