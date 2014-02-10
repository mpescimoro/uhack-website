module ApplicationHelper
	include FoundationRailsHelper::FlashHelper

	def link_uris(string, opt={})
    string.gsub URI.regexp do |match|
    	link_to match, match, opt
    end.html_safe
  end

	def logout_link(role, text='Logout', opt={})
		eval %Q{link_to text, destroy_#{role}_session_path, opt.merge!({method: :delete}) }
	end

	def login_link(role, text='Logout', opt={})
		eval %Q{link_to text, new_#{role}_session_path }
	end

	def topbar_logout_link(role, text=nil, opt={})
		content_tag :li, opt.merge!({class: 'divider'}) do 
			content_tag :li, logout_link(role, text || "Logout #{role.to_s.humanize.downcase}")
		end.html_safe if signed_in?(role)
	end

	def current_profile_link(role, text='Edit', opt={})
		eval %Q{link_to text, #{role}_profile_path(current_#{role})}
	end

	def topbar_profile_link(role, text=nil, opt={})
		content_tag :li, opt.merge!({class: 'divider'}) do 
			content_tag :li, current_profile_link(role, text || "Il mio profilo")
		end.html_safe if signed_in?(role)
	end

	def topbar_login_logout(role, role_name=nil, opt={})
		username = eval("current_#{role_name}.username") if signed_in?(role)
		content_tag :li, opt.merge!({class: 'divider'}) do
			role_name ||= role.to_s.humanize.downcase
			content_tag :li do
				signed_in?(role) ? logout_link(role, "Logout #{username}") : login_link(role, "Login")
			end
		end
	end

	def signed_in?(roles)
		if roles.respond_to? :inject
			roles.inject(false) do |signed, role|
				signed ||= eval "#{role}_signed_in?"
			end
		else
			eval "#{roles}_signed_in?"
		end
	end

	def posts_controller?
		params[:controller] == 'posts'
	end

	def content_tag_if(tag, condition, opt={}, &block)
		content_tag(tag, opt, &block) if condition
	end

	def profile_link(user, text=nil, opt={})
		return user.username if user.is_a? Guest
		path = user.is_a?(SuperUser) ? super_user_profile_path(user) : user_profile_path(user)
		link_to(text || user.username, path)
	end

end
