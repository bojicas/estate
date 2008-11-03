class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    if session[:emirate_id] && session[:emirate_name] && 
      session[:neighborhood_id] && session[:neighborhood_name]
      @projects = Project.find(:all, :conditions => "neighborhood_id = #{session[:neighborhood_id]}")
    else
      @projects = Project.find(:all)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /projects/select/1
  # there is no view for selected emirate
  def select
    begin
      project = Project.find(params[:id])       
      session[:emirate_id] = project.neighborhood.emirate.id
      session[:emirate_name] = project.neighborhood.emirate.name      
      session[:neighborhood_id] = project.neighborhood.id
      session[:neighborhood_name] = project.neighborhood.name
      session[:project_id] = project.id
      session[:project_name] = project.name
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to add an invalid project #{params[:id]}")
      flash[:error] = "Attempt to add an invalid project #{params[:id]}"
      redirect_to(projects_url)
    else
      flash[:notice] = "Switched to the project of #{project.name}."
      redirect_to(buildings_url)
    end
  end
  
  # GET /neighborhoods/reset/1
  # there is no view for selected emirate
  def reset
    session[:project_id] = nil
    session[:project_name] = nil
    session[:building_id] = nil
    session[:building_name] = nil
    flash[:notice] = "Selected value for Project has been reseted."
    redirect_to(request.env['HTTP_REFERR'] || projects_url)
  end
end
