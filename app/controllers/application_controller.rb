class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale] || :ru
  end

  include SessionsHelper

  def default_url_options(options={})
    { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  # def not_found
  #   render :file => 'public/404.html', :status => :not_found, :layout => false
  # end

  # rescue_from StandardError do |exception|
  #   ExceptionNotifier.notify_exception(exception, :env => request.env)
  #   # render 'errors/internal_server_error'
  #   puts "caught standard error: ", exception
  #   render layout: 'errors', action: 'error_internal_server_error', status: 500
  #
  # end
  #
  # rescue_from ActionController::RoutingError do |exception|
  #   #render 'errors/not_found'
  #   puts "caught routing error: ", exception
  #   render layout: 'errors', action: 'error_not_found', status: 404
  # end
  #
  # rescue_from CanCan::AccessDenied do |exception|
  #   #render 'errors/forbidden'
  #   render layout: 'errors', action: 'error_forbidden', status: 403
  # end


end
