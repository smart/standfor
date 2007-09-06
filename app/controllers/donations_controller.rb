class DonationsController < ApplicationController
  layout 'default'
  # GET /donations
  # GET /donations.xml
  def index
    @donations = Donation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @donations }
    end
  end

  # GET /donations/1
  # GET /donations/1.xml
  def show
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /donations/new
  # GET /donations/new.xml
  def new
    @donation = Donation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /donations/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  # POST /donations.xml
  def create
    @donation = Donation.new(params[:donation])

    respond_to do |format|
      if @donation.save
        flash[:notice] = 'Donation was successfully created.'
        format.html { redirect_to(@donation) }
        format.xml  { render :xml => @donation, :status => :created, :location => @donation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /donations/1
  # PUT /donations/1.xml
  def update
    @donation = Donation.find(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        flash[:notice] = 'Donation was successfully updated.'
        format.html { redirect_to(@donation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.xml
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to(donations_url) }
      format.xml  { head :ok }
    end
  end
end
