class SearchController < ApplicationController

  layout 'catalog'
  skip_before_filter :login_required

  def index   
    @property_types = Type.find(:all, :order => "name").map {|u| ["#{u.name}", u.id]}
     
    #session[:param_type_id] ||= String.new
    #session[:param_location] ||= String.new
    
    session[:param_type_id] = params[:type_id] if params[:type_id]
    session[:param_location] = params[:location] if params[:location]
    
    @properties = Property.paginate(:page => params[:page], 
      :include => [:building => [:project => [:neighborhood => :emirate]]], 
      :conditions => ["type_id = ? and (emirates.name LIKE ? or neighborhoods.name LIKE ? or projects.name LIKE ? or buildings.name LIKE ?)", params[:type_id], params[:location], params[:location], params[:location], params[:location]],
      :per_page => 5, 
      :order => 'properties.created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

end
