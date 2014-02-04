module ApplicationHelper
	include FoundationRailsHelper::FlashHelper
	include SuperRolesHelper

	def link_uris(string)
    string.gsub URI.regexp do |match|
      "<a href='#{match}'>#{match}</a>"
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
		end.html_safe if eval "#{role}_signed_in?" 
	end

	def topbar_login_logout(role, role_name=nil, opt={})
		content_tag :li, opt.merge!({class: 'divider'}) do
			role_name ||= role.to_s.humanize.downcase
			content_tag :li do
				signed_in?(role) ? logout_link(role, "Logout #{role_name}") : login_link(role, "Login #{role_name}")
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

end
