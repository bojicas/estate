class SearchController < ApplicationController

  layout 'catalog'
  skip_before_filter :login_required

  def index
    @properties = Property.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

end
