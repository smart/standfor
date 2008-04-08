class Admin::ConfigurationsController < ApplicationController
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin"
  # GET /admin_configurations
  # GET /admin_configurations.xml
  def index
    @configurations = Configuration.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_configurations }
    end
  end

  # GET /admin_configurations/1
  # GET /admin_configurations/1.xml
  def show
    @configuration = Configuration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @configuration }
    end
  end

  # GET /admin_configurations/new
  # GET /admin_configurations/new.xml
  def new
    @configuration = Configuration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @configuration }
    end
  end

  # GET /admin_configurations/1/edit
  def edit
    @configuration = Configuration.find(params[:id])
  end

  # POST /admin_configurations
  # POST /admin_configurations.xml
  def create
    @configuration = Configuration.new(params[:configuration])

    respond_to do |format|
      if @configuration.save
        flash[:notice] = 'Configuration was successfully created.'
        format.html { redirect_to admin_configuration_path(@configuration) }
        format.xml  { render :xml => @configuration, :status => :created, :location => @configuration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_configurations/1
  # PUT /admin_configurations/1.xml
  def update
    @configuration = Configuration.find(params[:id])

    respond_to do |format|
      if @configuration.update_attributes(params[:configuration])
        flash[:notice] = 'Configuration was successfully updated.'
        format.html { redirect_to admin_configuration_path(@configuration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_configurations/1
  # DELETE /admin_configurations/1.xml
  def destroy
    @configuration = Configuration.find(params[:id])
    @configuration.destroy

    respond_to do |format|
      format.html { redirect_to(admin_configurations_url) }
      format.xml  { head :ok }
    end
  end
end
