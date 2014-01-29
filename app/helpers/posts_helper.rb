module PostsHelper

	def tags_for(post)
		post.tags.inject("") do |list, tag|
			list << "##{tag.name} "
		end
	end

	def tags_list_element(tag, selected)
		name = selected ? content_tag(:b, tag.name) : tag.name
		path = selected ? posts_path : posts_with_tag_path(tag)
		link_to "##{name} (#{tag.posts.count})".html_safe, path
	end

end
