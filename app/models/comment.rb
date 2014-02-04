class Comment < ActiveRecord::Base

	belongs_to :commenter, polymorphic: true
	belongs_to :commentable, polymorphic: true

	validates :commenter_id, presence: true
	validates :commentable_id, presence: true

	def formatted_body
		link_uris!(self.body)
	end

	def currents?
		self.commenter == current_user || self.commenter == current_super_user
	end
end
