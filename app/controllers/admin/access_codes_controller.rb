class Admin::AccessCodesController < ApplicationController
  make_resourceful do
    actions :all
    belongs_to :account
  end
=begin
  before_filter :get_account
  # GET /admin_access_codes
  # GET /admin_access_codes.xml
  def index
    @access_codes = @account.access_codes 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_access_codes }
    end
  end

  # GET /admin_access_codes/1
  # GET /admin_access_codes/1.xml
  def show
    @access_code = AccessCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @access_code }
    end
  end

  # GET /admin_access_codes/new
  # GET /admin_access_codes/new.xml
  def new
    @access_code = AccessCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @access_code }
    end
  end

  # GET /admin_access_codes/1/edit
  def edit
    @access_code = AccessCode.find(params[:id])
  end

  # POST /admin_access_codes
  # POST /admin_access_codes.xml
  def create
    @access_code = AccessCode.new(params[:admin_access_code])

    respond_to do |format|
      if @access_code.save
        flash[:notice] = 'AccessCode was successfully created.'
        format.html { redirect_to admin_access_codes_url  }
        format.xml  { render :xml => @access_code, :status => :created, :location => @access_code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_access_codes/1
  # PUT /admin_access_codes/1.xml
  def update
    @access_code = AccessCode.find(params[:id])

    respond_to do |format|
      if @access_code.update_attributes(params[:admin_access_code])
        flash[:notice] = 'AccessCode was successfully updated.'
        format.html { redirect_to admin_access_codes_url  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_access_codes/1
  # DELETE /admin_access_codes/1.xml
  def destroy
    @access_code = AccessCode.find(params[:id])
    @access_code.destroy

    respond_to do |format|
      format.html { redirect_to(admin_access_codes_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def get_account
    @account = Account.find(params[:account_id])
  end
=end
end
