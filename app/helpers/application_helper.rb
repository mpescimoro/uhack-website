module ApplicationHelper
	include FoundationRailsHelper::FlashHelper

	def logout_link(role, text='Logout', opt={})
		eval %Q{link_to text, destroy_#{role}_session_path, opt.merge!({method: :delete}) }
	end

	def topbar_logout_link(role, text=nil, opt={})
		content_tag :li, opt.merge!({class: 'divider'}) do 
			content_tag :li, logout_link(role, text || "Logout #{role.to_s.humanize.downcase}")
		end.html_safe if eval "#{role}_signed_in?" 
	end

	def signed_in?(roles)
		roles.inject(false) do |signed, role|
			signed ||= eval "#{role}_signed_in?"
		end
	end

end
