module CommentsHelper
	def comment_commenter_signed_in?(comment)
		current_commenters.any? { |commenter| commenter == comment.commenter }
	end
end
