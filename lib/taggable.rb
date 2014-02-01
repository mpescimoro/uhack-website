module Taggable

	def add_or_create_tags(tag_names)
    tag_names.each do |name|
      if tag = Tag.where(name: name).first
        self.tagships.build(tag_id: tag.id)
      else
        self.tags.build(name: name)
      end
      self.save
    end
  end

  def update_tags(tag_names) #could be smarter and avoid destroying everything
  	tagships = self.tagships
  	self.tagships.delete_all
  	self.add_or_create_tags(tag_names)

  	tagships.map(&:tag).each do |tag|
  		tag.destroy if tag.posts.count == 0
  	end
  end

  def tagstring
  	self.tags.map(&:name).join(" ")
  end

end
