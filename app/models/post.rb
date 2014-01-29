class Post < ActiveRecord::Base

	belongs_to :creator, polymorphic: true
	has_many :tagships, dependent: :destroy
	has_many :tags, through: :tagships

	def publish_date
		published_at.strftime('%d/%m/%Y')
	end

	def add_or_create_tags(tag_names)
    tag_names.each do |name|
      if tag = Tag.where(name: name).first
        Tagship.create(tag_id: tag.id, post_id: self.id)
      else
        self.tags.build(name: name)
        self.save
      end
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
	
end
