class ErrorsController < BaseController
  def routing_error
    raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
  end
end
