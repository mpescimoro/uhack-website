module TagsHelper

	def tags_for(post, controller=params[:controller])
		post.tags.inject("") do |tags, tag|
			tags << taggify(tag, controller)
		end.html_safe
	end

	def taggify(tag, controller=params[:controller])
		path = controller ? eval("#{controller}_with_tag_path(tag)") : tags_path
		link_to tag_name(tag), path, class: 'tag'
	end

	def tag_list_elem(tag, selected_tag_id=0, controller=params[:controller])
		selected = selected_tag_id == tag.id
		#_class = selected ? 'selected_tag' : 'tag'
		path = if controller
				selected ? eval("#{controller}_path") : eval("#{controller}_with_tag_path(tag)")
			else
				selected ? tags_path : tag_path(tag)
			end
		link_to tag_name(tag, selected)+" ", path, class: 'tag', style: style_for(tag, controller.to_s.singularize)
	end

	private
	def style_for(tag, taggable_type=nil, scale=300)
		total_tagships = taggable_type ? Tagship.where(taggable_type: taggable_type.capitalize).count : Tagship.count
		percentage = 100
		percentage += scale * tag.tagships_count(taggable_type.capitalize) / total_tagships
		"font-size: #{percentage}%;"
	end

	def tag_name(tag, selected=false)
		selected ? "~#{tag.name}" : "\##{tag.name}"
	end

end
