class ErrorsController < ApplicationController
  def not_found
    render(:status => 404)
  end

  def internal_server_error
    render(:status => 500)
  end

  def forbidden
    render(:status => 403)
  end

  def unprocessable_entity
    render(:status => 422)
  end

  def request_entity_too_large
    render(:status => 413)
  end
end
