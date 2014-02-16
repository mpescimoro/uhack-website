module Taggable

  def self.included(includer)
    includer.class_eval do
      has_many :tagships, as: :taggable, dependent: :destroy
      has_many :tags, through: :tagships, dependent: :destroy
    end
  end

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
  	old_tagships = self.tagships.to_a
  	self.tagships.delete_all
  	self.add_or_create_tags(tag_names)

  	old_tagships.map(&:tag).each do |tag|
  		tag.destroy if tag.tagships.count == 0
  	end
  end

  def tagstring
  	self.tags.map(&:name).join(" ")
  end

end
