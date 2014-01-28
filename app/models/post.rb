class Post < ActiveRecord::Base

	def publish_date
		published_at.strftime('%d/%m/%Y')
	end
	
end
