class Post < ActiveRecord::Base
  include Taggable

  before_destroy :destroy_orphan_tags

	belongs_to :creator, polymorphic: true
	has_many :tagships,  as: :taggable, dependent: :destroy
	has_many :tags, through: :tagships


	def publish_date
		published_at.strftime('%d/%m/%Y')
	end

  def published?
    published_at ? true : false
  end

  private
  def destroy_orphan_tags
    self.tags.each do |tag|
      tag.destroy if tag.posts.count == 1
    end
  end
	
end
