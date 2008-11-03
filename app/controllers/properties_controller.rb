class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.xml
  def index
    if session[:emirate_id] && session[:emirate_name] && 
      session[:neighborhood_id] && session[:neighborhood_name] &&
      session[:project_id] && session[:project_name] &&
      session[:building_id] && session[:building_name]
      @properties = Property.find(:all, :conditions => "building_id = #{session[:building_id]}")
    else
      @properties = Property.find(:all)
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

  # GET /properties/1
  # GET /properties/1.xml
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.xml
  def new
    @property = Property.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
  end

  # POST /properties
  # POST /properties.xml
  def create
    @property = Property.new(params[:property])
    @property_photo = PropertyPhoto.new(:uploaded_data => params[:property_photo_file])
    
    @service = PropertyService.new(@property, @property_photo)

    respond_to do |format|
      if @service.save
        flash[:notice] = 'Property was successfully created.'
        format.html { redirect_to(@property) }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        flash[:error] = 'Property could not be saved.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.xml
  def update
    @property = Property.find(params[:id])
    @property_photo = @property.property_photo
    
    @service = PropertyService.new(@property, @property_photo)

    respond_to do |format|
      if @service.update_attributes(params[:property], params[:property_photo_file])
        flash[:notice] = 'Property was successfully updated.'
        format.html { redirect_to(@property) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.xml
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to(properties_url) }
      format.xml  { head :ok }
    end
  end
end
