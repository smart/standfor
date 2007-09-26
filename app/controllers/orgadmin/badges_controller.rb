class Orgadmin::BadgesController < ApplicationController
  layout '/orgadmin/default'
  # GET /orgadmin_badges
  # GET /orgadmin_badges.xml
  def index
    @orgadmin_badges = Orgadmin::Badge.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_badges }
    end
  end

  # GET /orgadmin_badges/1
  # GET /orgadmin_badges/1.xml
  def show
    @badge = Orgadmin::Badge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /orgadmin_badges/new
  # GET /orgadmin_badges/new.xml
  def new
    @badge = Orgadmin::Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /orgadmin_badges/1/edit
  def edit
    @badge = Orgadmin::Badge.find(params[:id])
  end

  # POST /orgadmin_badges
  # POST /orgadmin_badges.xml
  def create
    @badge = Orgadmin::Badge.new(params[:badge])

    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Orgadmin::Badge was successfully created.'
        format.html { redirect_to(@badge) }
        format.xml  { render :xml => @badge, :status => :created, :location => @badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_badges/1
  # PUT /orgadmin_badges/1.xml
  def update
    @badge = Orgadmin::Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Orgadmin::Badge was successfully updated.'
        format.html { redirect_to(@badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_badges/1
  # DELETE /orgadmin_badges/1.xml
  def destroy
    @badge = Orgadmin::Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_badges_url) }
      format.xml  { head :ok }
    end
  end
end
