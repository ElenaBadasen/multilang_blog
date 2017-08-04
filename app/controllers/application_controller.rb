class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale] || :ru
  end

  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  def default_url_options(options={})
    { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  def not_found
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end
