class AccessCodesController < ApplicationController
  # GET /access_codes
  # GET /access_codes.xml
  def index
    @access_codes = AccessCode.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @access_codes }
    end
  end

  # GET /access_codes/1
  # GET /access_codes/1.xml
  def show
    @access_code = AccessCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @access_code }
    end
  end

  # GET /access_codes/new
  # GET /access_codes/new.xml
  def new

    @access_code = AccessCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @access_code }
    end
  end

  # GET /access_codes/1/edit
  def edit
    @access_code = AccessCode.find(params[:id])
  end

  # POST /access_codes
  # POST /access_codes.xml
  def create
    @access_code = AccessCode.new(params[:access_code])

    respond_to do |format|
      if @access_code.save
        flash[:notice] = 'AccessCode was successfully created.'
        format.html { redirect_to(@access_code) }
        format.xml  { render :xml => @access_code, :status => :created, :location => @access_code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /access_codes/1
  # PUT /access_codes/1.xml
  def update
    @access_code = AccessCode.find(params[:id])

    respond_to do |format|
      if @access_code.update_attributes(params[:access_code])
        flash[:notice] = 'AccessCode was successfully updated.'
        format.html { redirect_to(@access_code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @access_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /access_codes/1
  # DELETE /access_codes/1.xml
  def destroy
    @access_code = AccessCode.find(params[:id])
    @access_code.destroy

    respond_to do |format|
      format.html { redirect_to(access_codes_url) }
      format.xml  { head :ok }
    end
  end
end
