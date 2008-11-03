class NeighborhoodsController < ApplicationController
  # GET /neighborhoods
  # GET /neighborhoods.xml
  def index
    if session[:emirate_id] && session[:emirate_name]
      @neighborhoods = Neighborhood.find(:all, :conditions => "emirate_id = #{session[:emirate_id]}")
    else
      @neighborhoods = Neighborhood.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @neighborhoods }
    end
  end

  # GET /neighborhoods/1
  # GET /neighborhoods/1.xml
  def show
    @neighborhood = Neighborhood.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @neighborhood }
    end
  end

  # GET /neighborhoods/new
  # GET /neighborhoods/new.xml
  def new
    @neighborhood = Neighborhood.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @neighborhood }
    end
  end

  # GET /neighborhoods/1/edit
  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  # POST /neighborhoods
  # POST /neighborhoods.xml
  def create
    @neighborhood = Neighborhood.new(params[:neighborhood])

    respond_to do |format|
      if @neighborhood.save
        flash[:notice] = 'Neighborhood was successfully created.'
        format.html { redirect_to(@neighborhood) }
        format.xml  { render :xml => @neighborhood, :status => :created, :location => @neighborhood }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @neighborhood.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /neighborhoods/1
  # PUT /neighborhoods/1.xml
  def update
    @neighborhood = Neighborhood.find(params[:id])

    respond_to do |format|
      if @neighborhood.update_attributes(params[:neighborhood])
        flash[:notice] = 'Neighborhood was successfully updated.'
        format.html { redirect_to(@neighborhood) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @neighborhood.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /neighborhoods/1
  # DELETE /neighborhoods/1.xml
  def destroy
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.destroy

    respond_to do |format|
      format.html { redirect_to(neighborhoods_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /neighborhood/select/1
  # there is no view for selected neighborhood
  def select
    begin
      neighborhood = Neighborhood.find(params[:id])
      session[:neighborhood_id] = neighborhood.id
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to add an invalid neighborhood #{params[:id]}")
      flash[:error] = "Attempt to add an invalid neighborhood #{params[:id]}"
      redirect_to(neighborhoods_url)
    else
      flash[:notice] = "Switched to the neighborhood of #{neighborhood.name}."
      redirect_to(request.env['HTTP_REFERR'] || neighborhoods_url)
    end
  end
  
  # GET /neighborhoods/select/1
  # there is no view for selected emirate
  def select
    begin
      neighborhood = Neighborhood.find(params[:id])       
      session[:emirate_id] = neighborhood.emirate.id
      session[:emirate_name] = neighborhood.emirate.name      
      session[:neighborhood_id] = neighborhood.id
      session[:neighborhood_name] = neighborhood.name
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to add an invalid neighborhood #{params[:id]}")
      flash[:error] = "Attempt to add an invalid neighborhood #{params[:id]}"
      redirect_to(neighborhoods_url)
    else
      flash[:notice] = "Switched to the neighborhood of #{neighborhood.name}."
      redirect_to(projects_url)
    end
  end
  
  # GET /neighborhoods/reset/1
  # there is no view for selected emirate
  def reset
    session[:neighborhood_id] = nil
    session[:neighborhood_name] = nil
    session[:project_id] = nil
    session[:project_name] = nil
    session[:building_id] = nil
    session[:building_name] = nil
    flash[:notice] = "Selected value for Neighborhood has been reseted."
    redirect_to(request.env['HTTP_REFERR'] || neighborhoods_url)
  end
end
