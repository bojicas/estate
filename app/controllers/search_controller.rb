class SearchController < ApplicationController

  layout 'catalog'
  skip_before_filter :login_required

  def index   
    @property_types = Type.find(:all, :order => "name").map {|u| ["#{u.name}", u.id]}
     
    #session[:param_type_id] ||= String.new
    session[:param_location] ||= String.new
    
    session[:param_type_id] = params[:type_id] if params[:type_id]
    session[:param_location] = params[:location] if params[:location]
    
    if session[:param_location].empty?
      conditions = ["type_id = ?", session[:param_type_id]]   
    else
      conditions = ["type_id = ? and (emirates.name LIKE ? or neighborhoods.name LIKE ? or projects.name LIKE ? or buildings.name LIKE ?)", session[:param_type_id], session[:param_location], session[:param_location], session[:param_location], session[:param_location]] 
    end
    
    @properties = Property.paginate( 
      :include => [:building => [:project => [:neighborhood => :emirate]]], 
      :conditions => conditions,
      :per_page => 3,
      :page => params[:page], 
      :order => 'properties.created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

end
