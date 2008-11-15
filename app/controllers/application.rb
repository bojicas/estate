# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  include SimpleCaptcha::ControllerHelpers
      
  session :session_key => '_estate_session_id'

  before_filter :login_required
  # To skip this in a subclassed controller:
  #   skip_before_filter :login_required
  # See lib/authenticated_system.tb for more details
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'f90fa8fa7488d62930e2a3fc3c0ae538'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
