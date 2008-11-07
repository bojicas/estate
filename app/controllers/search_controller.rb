class SearchController < ApplicationController

  layout 'catalog'
  skip_before_filter :login_required

  def index    
    session[:param_emirate] ||= String.new
    session[:param_neighborhood] ||= String.new
    
    session[:param_emirate] = params[:emirate] if params[:emirate]
    session[:param_neighborhood] = params[:neighborhood] if params[:neighborhood]
    
    conditions = nil
    
    conditions = ["emirates.name LIKE ? AND neighborhoods.name LIKE ?", 
      session[:param_emirate],
      session[:param_neighborhood]] unless session[:param_emirate].empty? || 
        session[:param_neighborhood].empty?
      
    conditions = ["emirates.name LIKE ?", 
      session[:param_emirate]] if !session[:param_emirate].empty? && 
        session[:param_neighborhood].empty?    

    conditions = ["neighborhoods.name LIKE ?", 
      session[:param_neighborhood]] if session[:param_emirate].empty? && 
        !session[:param_neighborhood].empty?
    
    @properties = Property.paginate(:page => params[:page], 
      :include => [:building => [:project => [:neighborhood => :emirate]]], 
      :conditions => conditions,
      :per_page => 5, 
      :order => 'properties.created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

end
