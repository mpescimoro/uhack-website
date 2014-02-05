class Comment < ActiveRecord::Base
	include SuperRolesHelper

	belongs_to :commenter, polymorphic: true
	belongs_to :commentable, polymorphic: true

	validates :commenter_id, presence: true
	validates :commentable_id, presence: true

end
