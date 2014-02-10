module TagsHelper

	def tags_for(post, controller=params[:controller])
		post.tags.inject("") do |tags, tag|
			tags << taggify(tag, controller)
		end.html_safe
	end

	def taggify(tag, controller=params[:controller])
		path = controller ? eval("#{controller}_with_tag_path(tag)") : tags_path
		link_to tag.name, path, class: 'tag'
	end

	def tag_list_elem(tag, selected_tag_id=0, controller=params[:controller])
		selected = selected_tag_id == tag.id
		_class = selected ? 'selected_tag' : 'tag'
		path = if controller
				selected ? eval("#{controller}_path") : eval("#{controller}_with_tag_path(tag)")
			else
				selected ? tags_path : tag_path(tag)
			end
		link_to "#{tag.name} (#{tag.posts_count})".html_safe, path, class: _class
	end
	
end
