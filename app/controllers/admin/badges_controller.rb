class Admin::BadgesController < ApplicationController
 layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 

  # GET /admin_badges
  # GET /admin_badges.xml
  def index
    @badges = Admin::Badge.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_badges }
    end
  end

  # GET /admin_badges/1
  # GET /admin_badges/1.xml
  def show
    @badge = Admin::Badge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /admin_badges/new
  # GET /admin_badges/new.xml
  def new
    @badge = Admin::Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /admin_badges/1/edit
  def edit
    @badge = Admin::Badge.find(params[:id])
  end

  # POST /admin_badges
  # POST /admin_badges.xml
  def create
    @badge = Admin::Badge.new(params[:badge])

    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Admin::Badge was successfully created.'
        format.html { redirect_to(@badge) }
        format.xml  { render :xml => @badge, :status => :created, :location => @badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_badges/1
  # PUT /admin_badges/1.xml
  def update
    @badge = Admin::Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Admin::Badge was successfully updated.'
        format.html { redirect_to(@badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_badges/1
  # DELETE /admin_badges/1.xml
  def destroy
    @badge = Admin::Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(admin_badges_url) }
      format.xml  { head :ok }
    end
  end
end
