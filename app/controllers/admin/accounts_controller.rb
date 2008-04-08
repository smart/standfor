class Admin::AccountsController < ApplicationController
  layout 'application'
  before_filter :login_required

  # GET /admin_accounts
  # GET /admin_accounts.xml
  def index
    @accounts = Account.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_accounts }
    end
  end

  # GET /admin_accounts/1
  # GET /admin_accounts/1.xml
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /admin_accounts/new
  # GET /admin_accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /admin_accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /admin_accounts
  # POST /admin_accounts.xml
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        flash[:notice] = 'Account was successfully created.'
        format.html { redirect_to(@account) }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_accounts/1
  # PUT /admin_accounts/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        flash[:notice] = 'Account was successfully updated.'
        format.html { redirect_to(edit_admin_account_path(@account) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_accounts/1
  # DELETE /admin_accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(admin_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
