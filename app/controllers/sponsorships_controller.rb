class SponsorshipsController < ApplicationController
  helper 'sponsorships'
  before_filter :login_required
  before_filter :get_sponsor
  # GET /sponsorships
  # GET /sponsorships.xml
  def index
    @sponsorships = Sponsorship.find(:all, :conditions => ["sponsor_id = ? ", @sponsor.id ] )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sponsorships }
    end
  end

  # GET /sponsorships/1
  # GET /sponsorships/1.xml
  def show
    @sponsorship = Sponsorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sponsorship }
    end
  end

  # GET /sponsorships/new
  # GET /sponsorships/new.xml
  def new
    @sponsorship = Sponsorship.new
    @sponsorable = params[:sponsorable_type].constantize.find_by_id(params[:sponsorable_id]) 
    @checked = {}
    @checked['Organization'] = {} 
    @checked['Organization'][1] = true
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sponsorship }
    end
  end

  # GET /sponsorships/1/edit
  def edit
    @sponsorship = Sponsorship.find(params[:id])
  end

  # POST /sponsorships
  # POST /sponsorships.xml
  def create
    sponsorables = []
    params[:sponsorable].keys.each do |key|
      params[:sponsorable][key].keys.each do |id|
        sponsorables << key.constantize.find_by_id(id) 
      end
    end

    sponsorables.each do |sponsorable|
 	@sponsor.sponsor(sponsorable)
    end

    @sponsorship = Sponsorship.new(params[:sponsorship])
    @sponsorship.sponsor = @sponsor
    respond_to do |format|
      if @sponsorship.save
        flash[:notice] = 'Sponsorship was successfully created.'
        format.html { redirect_to(@sponsorship) }
        format.xml  { render :xml => @sponsorship, :status => :created, :location => @sponsorship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sponsorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sponsorships/1
  # PUT /sponsorships/1.xml
  def update
    @sponsorship = Sponsorship.find(params[:id])

    respond_to do |format|
      if @sponsorship.update_attributes(params[:sponsorship])
        flash[:notice] = 'Sponsorship was successfully updated.'
        format.html { redirect_to(@sponsorship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sponsorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsorships/1
  # DELETE /sponsorships/1.xml
  def destroy
    @sponsorship = Sponsorship.find(params[:id])
    @sponsorship.destroy

    respond_to do |format|
      format.html { redirect_to(sponsorships_url) }
      format.xml  { head :ok }
    end
  end

  private 

  def get_sponsor
    @sponsor = current_account.sponsor
  end

end
