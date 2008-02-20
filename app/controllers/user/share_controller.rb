class User::ShareController < ApplicationController
  layout :get_layout
  before_filter :login_required
  before_filter :get_my_badge

    def index 
      @customizations = Customization.commit(@my_badge.adi_id)
      @webapps  = Younety::Remote::Webapp.find(:all)
    end
    
    def webapp_choose
     
      @shares = Younety::Remote::Share.find(:all).select do |share|
        p share.webapp_id.to_s
        p params[:webapp].to_s
        share.webapp_id.to_s == params[:webapp].to_s
      end
  
      if @shares.size == 1
        @share = @shares.first
        p @share
        render :action => 'choose.rjs'
      else
        render :action => "webapp_choose.rjs"
      end
    end

    def choose
      @share  = Younety::Remote::Share.find(params[:share]) 
      render :action => 'choose.rjs'
    end

    def do 
      @response = Younety::Remote::Share.share_it(params[:share], @my_badge.adi_id, params[:share_it])
      @failed = @response.code == "200" ? false : true
      render :action => "do.rjs"
    end

    def download_signature
       @share  = Younety::Remote::Share.find("Embed%20Code", :params => {:adi_id => @my_badge.adi_id }  ) 
       send_data @share.snippet.strip , :filename => "standfor.signature.#{@my_badge.adi_id}.html", :type =>'text/plain' , :disposition => 'attachment'
    end

   def signature_one
     render :action => 'signature_one.rjs'
   end

   def signature_two
     @client = params[:q]
     render :action => 'signature_two.rjs'
   end

   def signature_three
     render :action => 'signature_three.rjs'
   end

   def signature_four
     render :action => 'signature_four.rjs'
   end

   def instructions
      @share  = Younety::Remote::Share.find(params[:share]) 
   end


   private 

   def get_my_badge
     @my_badge = current_account.my_badges.find(params[:my_badge_id])
   end

   def get_layout
      params[:action] == 'instructions' ?  'popup' : 'default'
   end

end
