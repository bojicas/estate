class FollowUpController < ApplicationController
  def property
    begin
      @property = Property.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Property not found"
      # redirect_to :back
    end
    
    

    respond_to do |format|
      format.html # property.html.erb
      format.xml  { render :xml => @property }
    end
  end
end
