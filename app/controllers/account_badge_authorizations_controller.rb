class AccountBadgeAuthorizationsController < ApplicationController
  before_filter :account_required
  layout 'default'
  # GET /account_badge_authorizations
  # GET /account_badge_authorizations.xml
  def index
    @account_badge_authorizations = AccountBadgeAuthorization.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account_badge_authorizations }
    end
  end

  # GET /account_badge_authorizations/1
  # GET /account_badge_authorizations/1.xml
  def show
    @account_badge_authorization = AccountBadgeAuthorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account_badge_authorization }
    end
  end

  # GET /account_badge_authorizations/new
  # GET /account_badge_authorizations/new.xml
  def new
    @requirement = Requirement.find(params[:requirement])
    @account_badge_authorization = AccountBadgeAuthorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account_badge_authorization }
    end
  end

  # GET /account_badge_authorizations/1/edit
  def edit
    @account_badge_authorization = AccountBadgeAuthorization.find(params[:id])
  end

  # POST /account_badge_authorizations
  # POST /account_badge_authorizations.xml
  def create
    @requirement = Requirement.find(params[:requirement])

    begin
     @badge_access_code = BadgeAccessCode.find(:first, :conditions => ["value = ? and badge_id = ?", params[:account_badge_authorization][:code],  @requirement.badge.id ] )
    rescue
	render :action => "new" and return
    end
 
    @account_badge_authorization = AccountBadgeAuthorization.new()
    @account_badge_authorization.account = current_account 
    @account_badge_authorization.badge = @requirement.badge
    @account_badge_authorization.badge_access_code = @badge_access_code 

    respond_to do |format|
      
      if @account_badge_authorization.save
        flash[:notice] = 'AccountBadgeAuthorization was successfully created.'
        #format.html { redirect_to(@account_badge_authorization) }
        format.html { redirect_back_or_default('/') }
        format.xml  { render :xml => @account_badge_authorization, :status => :created, :location => @account_badge_authorization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account_badge_authorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_badge_authorizations/1
  # PUT /account_badge_authorizations/1.xml
  def update
    @account_badge_authorization = AccountBadgeAuthorization.find(params[:id])

    respond_to do |format|
      if @account_badge_authorization.update_attributes(params[:account_badge_authorization])
        flash[:notice] = 'AccountBadgeAuthorization was successfully updated.'
        format.html { redirect_to(@account_badge_authorization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account_badge_authorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_badge_authorizations/1
  # DELETE /account_badge_authorizations/1.xml
  def destroy
    @account_badge_authorization = AccountBadgeAuthorization.find(params[:id])
    @account_badge_authorization.destroy

    respond_to do |format|
      format.html { redirect_to(account_badge_authorizations_url) }
      format.xml  { head :ok }
    end
  end
end
