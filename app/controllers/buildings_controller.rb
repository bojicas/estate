class BuildingsController < ApplicationController
  # GET /buildings
  # GET /buildings.xml
  def index
    
    if session[:emirate_id] && session[:emirate_name] && 
      session[:neighborhood_id] && session[:neighborhood_name] &&
      session[:project_id] && session[:project_name]
      @buildings = Building.find(:all, :conditions => "project_id = #{session[:project_id]}")
    else
      @buildings = Building.find(:all)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buildings }
    end
  end

  # GET /buildings/1
  # GET /buildings/1.xml
  def show
    @building = Building.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @building }
    end
  end

  # GET /buildings/new
  # GET /buildings/new.xml
  def new
    @building = Building.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @building }
    end
  end

  # GET /buildings/1/edit
  def edit
    @building = Building.find(params[:id])
  end

  # POST /buildings
  # POST /buildings.xml
  def create
    @building = Building.new(params[:building])

    respond_to do |format|
      if @building.save
        flash[:notice] = 'Building was successfully created.'
        format.html { redirect_to(@building) }
        format.xml  { render :xml => @building, :status => :created, :location => @building }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @building.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buildings/1
  # PUT /buildings/1.xml
  def update
    @building = Building.find(params[:id])

    respond_to do |format|
      if @building.update_attributes(params[:building])
        flash[:notice] = 'Building was successfully updated.'
        format.html { redirect_to(@building) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @building.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.xml
  def destroy
    @building = Building.find(params[:id])
    @building.destroy

    respond_to do |format|
      format.html { redirect_to(buildings_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /buildings/select/1
   # there is no view for selected emirate
   def select
     begin
       building = Building.find(params[:id])       
       session[:emirate_id] = building.project.neighborhood.emirate.id
       session[:emirate_name] = building.project.neighborhood.emirate.name      
       session[:neighborhood_id] = building.project.neighborhood.id
       session[:neighborhood_name] = building.project.neighborhood.name
       session[:project_id] = building.project.id
       session[:project_name] = building.project.name
       session[:building_id] = building.id
       session[:building_name] = building.name
     rescue ActiveRecord::RecordNotFound
       logger.error("Attempt to add an invalid building #{params[:id]}")
       flash[:error] = "Attempt to add an invalid building #{params[:id]}"
       redirect_to(buildings_url)
     else
       flash[:notice] = "Switched to the project of #{building.name}."
       redirect_to(properties_url)
     end
   end

   # GET /nbuildings/reset/1
   # there is no view for selected emirate
   def reset
     session[:building_id] = nil
     session[:building_name] = nil
     flash[:notice] = "Selected value for Project has been reseted."
     redirect_to(request.env['HTTP_REFERR'] || buildings_url)
   end
end
