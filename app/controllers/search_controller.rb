class SearchController < ApplicationController

  layout 'catalog'
  skip_before_filter :login_required

  def index
  end

end
