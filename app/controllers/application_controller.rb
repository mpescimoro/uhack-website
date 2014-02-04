class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location

  def authenticate_any!(roles=[])
    msg = "Spiacente, devi essere loggato per farlo"
  	redirect_to root_path, alert: msg unless roles.inject(false) do |logged, role|
  		logged ||= eval "#{role}_signed_in?"
  	end
  end

  def store_location
    unless devise_path? || request.xhr? # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  protected
  def link_uris!(string)
    string.gsub! URI.regexp do |match|
      "<a href='#{match}'>#{match}</a>"
    end
  end

  def devise_parameter_sanitizer
  	if resource_class == SuperUser
  		SuperUser::ParameterSanitizer.new(SuperUser, :user, params)
  	else
  		super
  	end
  end

  def devise_path?
    %w{super_user admin}.inject(false) do |result, role|
      result || request.fullpath.starts_with?("/#{role.pluralize}")
    end
  end

end
