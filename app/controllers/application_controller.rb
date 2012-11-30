class ApplicationController < ActionController::Base
  protect_from_forgery
  def not_found
#    redirect_to :status => 404 and return
    raise ActionController::RoutingError.new('Not Found')
  end
end
