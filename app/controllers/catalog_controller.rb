class CatalogController < ApplicationController
  
  skip_before_filter :login_required
  
  def index
    @properties = Property.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end
  
  # GET /catalog/1
  # GET /catalog/1.xml
  def show
    @property = Property.find(params[:id])
    @inquiry = Inquiry.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end
end
