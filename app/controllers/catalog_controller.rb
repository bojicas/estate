class CatalogController < ApplicationController
  
  skip_before_filter :login_required
  
  def index
    @property_types = Type.find(:all, :order => "name").map {|u| ["#{u.name}", u.id]}
    @hot_properties = Property.find(:all, 
      :conditions => ["hot = ? and available =? and sold = ?", true, true, false], 
      :order => 'updated_at DESC',
      :limit => 5)
    @properties = Property.find(:all, 
      :conditions => ["available =? and sold = ?", true, false], 
      :order => 'created_at DESC', 
      :limit => 25)
    
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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end
  
end
