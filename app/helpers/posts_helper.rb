module PostsHelper
	include TagsHelper

	def tags_list(slected_tag_id)
		html=""
		Tag.all.each do |tag|
			html += tag_list_elem(tag, slected_tag_id) if tag.posts_count > 0
		end
		html.html_safe
	end

end
