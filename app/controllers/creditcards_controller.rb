class CreditcardsController < ApplicationController
  layout 'default'
  before_filter :login_required
  before_filter :order_required

  # GET /creditcards/new
  # GET /creditcards/new.xml
  def new
    @creditcard = Creditcard.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creditcard }
    end
  end

  # POST /creditcards
  # POST /creditcards.xml
  def create
    creditcard = ActiveMerchant::Billing::CreditCard.new(
      :type   => params[:creditcard][:card_type].downcase ,
      :number => params[:creditcard][:number],
      :month => params[:date][:month],
      :year  => params[:date][:year],
      :first_name => params[:creditcard][:first_name],
      :last_name  => params[:creditcard][:last_name] ,
      :verification_value => params[:creditcard][:verification_value] )

    respond_to do |format|
      if creditcard.valid?
        flash[:notice] = "The credit card information is valid."
        @order.creditcard = creditcard 
        format.html { redirect_to session[:creditcard_redirect] }
      else
        flash[:error] = "The credit card information entered is not valid."
        creditcard.errors.each do |error, msg|
            flash[:error] +=  "<br />#{error.to_s}  #{msg.to_s}"
        end
        format.html { render :action => "new" }
      end
    end

  end

  private  

  def order_required
    @order = session[:order]
  end

end
