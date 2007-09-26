class BadgeAccessCodesController < ApplicationController
  # GET /badge_access_codes
  # GET /badge_access_codes.xml
  before_filter :get_organization 
  def index
    @badge_access_codes = BadgeAccessCode.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @badge_access_codes }
    end
  end

  # GET /badge_access_codes/1
  # GET /badge_access_codes/1.xml
  def show
    @badge_access_code = BadgeAccessCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge_access_code }
    end
  end

  # GET /badge_access_codes/new
  # GET /badge_access_codes/new.xml
  def new
    @badge_access_code = BadgeAccessCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge_access_code }
    end
  end

  # GET /badge_access_codes/1/edit
  def edit
    @badge_access_code = BadgeAccessCode.find(params[:id])
  end

  # POST /badge_access_codes
  # POST /badge_access_codes.xml
  def create
    @badge_access_code = BadgeAccessCode.new(params[:badge_access_code])

    respond_to do |format|
      if @badge_access_code.save
        flash[:notice] = 'BadgeAccessCode was successfully created.'
        format.html { redirect_to(@badge_access_code) }
        format.xml  { render :xml => @badge_access_code, :status => :created, :location => @badge_access_code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge_access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /badge_access_codes/1
  # PUT /badge_access_codes/1.xml
  def update
    @badge_access_code = BadgeAccessCode.find(params[:id])

    respond_to do |format|
      if @badge_access_code.update_attributes(params[:badge_access_code])
        flash[:notice] = 'BadgeAccessCode was successfully updated.'
        format.html { redirect_to(@badge_access_code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge_access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /badge_access_codes/1
  # DELETE /badge_access_codes/1.xml
  def destroy
    @badge_access_code = BadgeAccessCode.find(params[:id])
    @badge_access_code.destroy

    respond_to do |format|
      format.html { redirect_to(badge_access_codes_url) }
      format.xml  { head :ok }
    end
  end

  private
  def get_organization
    @organization = Organization.find(params[:organization_id] )
  end

end
