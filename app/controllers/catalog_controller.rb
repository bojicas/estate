class CatalogController < ApplicationController
  
  skip_before_filter :login_required
  
  def index
    @title = "UAE's Real Estate Golden Index - Home Page"
    @property_types = Type.find(:all, :order => "name").map {|u| ["#{u.name}", u.id]}
    @hot_properties = Property.find(:all, 
      :conditions => ["hot = ? and available =? and sold = ?", true, true, false], 
      :order => 'updated_at DESC',
      :limit => 5)
      
    @properties_dubai = Property.find(:all, 
      :include => [:building => [:project => [:neighborhood => :emirate]]],
      :conditions => ["available =? and sold = ? and emirates.name like ?", true, false, 'dubai'], 
      :order => 'properties.created_at DESC', 
      :limit => 50)
      
    @properties_ajman = Property.find(:all, 
      :include => [:building => [:project => [:neighborhood => :emirate]]],
      :conditions => ["available =? and sold = ? and emirates.name like ?", true, false, 'ajman'], 
      :order => 'properties.created_at DESC', 
      :limit => 50)
  
    @properties = Property.find(:all, 
       :include => [:building => [:project => [:neighborhood => :emirate]]],
       :conditions => ["available =? and sold = ? and emirates.name not like ? and emirates.name not like ?", true, false, 'Dubai', 'Ajman'], 
       :order => 'properties.created_at DESC', 
       :limit => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end
  
  # GET /catalog/1
  # GET /catalog/1.xml
  def show
    @property_types = Type.find(:all, :order => "name").map {|u| ["#{u.name}", u.id]}
    @property = Property.find(params[:id])
    @inquiry = Inquiry.new
    @title = "UAE's Real Estate Golden Index - Property ref. # #{params[:id]}"
    @average_price = Property.average(:price, 
      :include => [:building => [:project => :neighborhood]],
      :conditions => ["neighborhoods.id = ?", @property.building.project.neighborhood.id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end
  
end
