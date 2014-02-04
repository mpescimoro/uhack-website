module TagsHelper

	def tags_for(post)
		post.tags.inject("") do |tags, tag|
			tags << taggify(tag)
		end.html_safe
	end

	def taggify(tag)
		link_to tag.name, posts_with_tag_path(tag.name), class: 'tag'
	end

	def tag_list_elem(tag, selected_tag_id=0)
		selected = selected_tag_id == tag.id
		_class = selected ? ' selected_tag' : ' tag'
		path = selected ? posts_path : posts_with_tag_path(tag.name)
		link_to "#{tag.name} (#{tag.published_posts_count})".html_safe, path, class: _class
	end
	
end
