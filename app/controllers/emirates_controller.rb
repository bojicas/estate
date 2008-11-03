class EmiratesController < ApplicationController
  # GET /emirates
  # GET /emirates.xml
  def index
    @emirates = Emirate.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emirates }
    end
  end

  # GET /emirates/1
  # GET /emirates/1.xml
  def show
    @emirate = Emirate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @emirate }
    end
  end

  # GET /emirates/new
  # GET /emirates/new.xml
  def new
    @emirate = Emirate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @emirate }
    end
  end

  # GET /emirates/1/edit
  def edit
    @emirate = Emirate.find(params[:id])
  end

  # POST /emirates
  # POST /emirates.xml
  def create
    @emirate = Emirate.new(params[:emirate])

    respond_to do |format|
      if @emirate.save
        flash[:notice] = 'Emirate was successfully created.'
        format.html { redirect_to(@emirate) }
        format.xml  { render :xml => @emirate, :status => :created, :location => @emirate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @emirate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /emirates/1
  # PUT /emirates/1.xml
  def update
    @emirate = Emirate.find(params[:id])

    respond_to do |format|
      if @emirate.update_attributes(params[:emirate])
        flash[:notice] = 'Emirate was successfully updated.'
        format.html { redirect_to(@emirate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @emirate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /emirates/1
  # DELETE /emirates/1.xml
  def destroy
    @emirate = Emirate.find(params[:id])
    @emirate.destroy

    respond_to do |format|
      format.html { redirect_to(emirates_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /emirates/select/1
  # there is no view for selected emirate
  def select
    begin
      emirate = Emirate.find(params[:id])
      session[:emirate_id] = emirate.id
      session[:emirate_name] = emirate.name
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to add an invalid emirate #{params[:id]}")
      flash[:error] = "Attempt to add an invalid emirate #{params[:id]}"
      redirect_to(emirates_url)
    else
      flash[:notice] = "Switched to the emirate of #{emirate.name}."
      redirect_to(neighborhoods_url)
    end
  end
  
  # GET /emirates/reset/1
  # there is no view for selected emirate
  def reset
    session[:emirate_id] = nil
    session[:emirate_name] = nil
    session[:neighborhood_id] = nil
    session[:neighborhood_name] = nil
    session[:project_id] = nil
    session[:project_name] = nil
    session[:building_id] = nil
    session[:building_name] = nil
    flash[:notice] = "Selected value for Emirate has been reseted."
    redirect_to(request.env['HTTP_REFERR'] || emirates_url)
  end
end
