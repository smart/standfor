class User::AccountsController < ApplicationController
  before_filter :login_required
  # GET /user_accounts
  # GET /user_accounts.xml
  def index
    @accounts = User::Account.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_accounts }
    end
  end

  # GET /user_accounts/1
  # GET /user_accounts/1.xml
  def show
    @account = current_account
    @my_badges = current_account.my_badges
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /user_accounts/new
  # GET /user_accounts/new.xml
  def new
    @account = User::Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /user_accounts/1/edit
  def edit
    @account = current_account
  end

  # POST /user_accounts
  # POST /user_accounts.xml
  def create
    @account = current_account

    respond_to do |format|
      if @account.save
        flash[:notice] = 'User::Account was successfully created.'
        format.html { redirect_to(@account) }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_accounts/1
  # PUT /user_accounts/1.xml
  def update
    @account = current_account 
    respond_to do |format|
      if @account.update_attributes(params[:account])
        flash[:notice] = 'Account was successfully updated.'
        format.html { redirect_to user_account_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_accounts/1
  # DELETE /user_accounts/1.xml
  def destroy
    @account = User::Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(user_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
