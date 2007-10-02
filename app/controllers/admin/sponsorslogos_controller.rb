class Admin::SponsorslogosController < ApplicationController
  layout '/admin/default'
  before_filter :get_sponsor
  # GET /admin_sponsorslogos
  # GET /admin_sponsorslogos.xml
  def index

    @sponsorslogos = Sponsorslogo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_sponsorslogos }
    end
  end

  # GET /admin_sponsorslogos/1
  # GET /admin_sponsorslogos/1.xml
  def show
    @sponsorslogo = Sponsorslogo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sponsorslogo }
    end
  end

  # GET /admin_sponsorslogos/new
  # GET /admin_sponsorslogos/new.xml
  def new
    @sponsorslogo = Sponsorslogo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sponsorslogo }
    end
  end

  # GET /admin_sponsorslogos/1/edit
  def edit
    @sponsorslogo = Sponsorslogo.find(params[:id])
  end

  # POST /admin_sponsorslogos
  # POST /admin_sponsorslogos.xml
  def create
     Sponsorslogo.find(:all, :conditions => ["sponsor_id = ? ",  @sponsor.id ]).each do |logo| 
       logo.destroy
     end

    begin
      @sponsorslogo =  Sponsorslogo.create! params[:sponsorslogo]
      @sponsorslogo.sponsor_id  = @sponsor.id
      @sponsorslogo.save
      flash[:notice] = 'Sponsorslogo was successfully created.'
      redirect_to admin_sponsor_sponsorslogo_url(@sponsor, @sponsorslogo ) 
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end

  end

  # PUT /admin_sponsorslogos/1
  # PUT /admin_sponsorslogos/1.xml
  def update
    @sponsorslogo = Sponsorslogo.find(params[:id])

    respond_to do |format|
      if @sponsorslogo.update_attributes(params[:sponsorslogo])
        flash[:notice] = 'Sponsorslogo was successfully updated.'
        format.html { redirect_to(@sponsorslogo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sponsorslogo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_sponsorslogos/1
  # DELETE /admin_sponsorslogos/1.xml
  def destroy
    @sponsorslogo = Sponsorslogo.find(params[:id])
    @sponsorslogo.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sponsorslogos_url) }
      format.xml  { head :ok }
    end
  end
  private

  def get_sponsor
    @sponsor = Sponsor.find(params[:sponsor_id])
  end

end
