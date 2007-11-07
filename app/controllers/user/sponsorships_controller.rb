class User::SponsorshipsController < ApplicationController
  before_filter :login_required
  layout 'default'
  # GET /user_sponsorships
  # GET /user_sponsorships.xml
  def index
    @sponsorships = Sponsorship.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_sponsorships }
    end
  end

  # GET /user_sponsorships/1
  # GET /user_sponsorships/1.xml
  def show
    @sponsorship = User::Sponsorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sponsorship }
    end
  end

  # GET /user_sponsorships/new
  # GET /user_sponsorships/new.xml
  def new
    @sponsorship = User::Sponsorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sponsorship }
    end
  end

  # GET /user_sponsorships/1/edit
  def edit
    @sponsorship = User::Sponsorship.find(params[:id])
  end

  # POST /user_sponsorships
  # POST /user_sponsorships.xml
  def create
    @sponsorship = User::Sponsorship.new(params[:sponsorship])

    respond_to do |format|
      if @sponsorship.save
        flash[:notice] = 'User::Sponsorship was successfully created.'
        format.html { redirect_to(@sponsorship) }
        format.xml  { render :xml => @sponsorship, :status => :created, :location => @sponsorship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sponsorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_sponsorships/1
  # PUT /user_sponsorships/1.xml
  def update
    @sponsorship = User::Sponsorship.find(params[:id])

    respond_to do |format|
      if @sponsorship.update_attributes(params[:sponsorship])
        flash[:notice] = 'User::Sponsorship was successfully updated.'
        format.html { redirect_to(@sponsorship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sponsorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sponsorships/1
  # DELETE /user_sponsorships/1.xml
  def destroy
    @sponsorship = User::Sponsorship.find(params[:id])
    @sponsorship.destroy

    respond_to do |format|
      format.html { redirect_to(user_sponsorships_url) }
      format.xml  { head :ok }
    end
  end
end
