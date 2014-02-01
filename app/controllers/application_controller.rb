class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_any!(roles=[])
    msg = "Spiacente, devi essere loggato per farlo"
  	redirect_to root_path, alert: msg unless roles.inject(false) do |logged, role|
  		logged ||= eval "#{role}_signed_in?"
  	end
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

end
