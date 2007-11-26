class UsersController < ApplicationController
   layout 'default'

   def show
      @account = Account.find(params[:id])
   end

end
