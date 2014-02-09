module Profileable
	def image_url
		super || 'default_avatar.jpg'
	end
end