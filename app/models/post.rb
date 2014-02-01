class Post < ActiveRecord::Base

  before_destroy :destroy_orphan_tags

	belongs_to :creator, polymorphic: true
	has_many :tagships,  as: :taggable, dependent: :destroy
	has_many :tags, through: :tagships


	def publish_date
		published_at.strftime('%d/%m/%Y')
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

  def update_tags(tag_names) #could/should be more efficient than that
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

  private
  def destroy_orphan_tags
    self.tags.each do |tag|
      tag.destroy if tag.posts.count == 1
    end
  end
	
end
