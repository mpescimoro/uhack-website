class Tag < ActiveRecord::Base

	has_many :tagships, dependent: :destroy
	has_many :posts, through: :tagships, source: :taggable, source_type: 'Post'

	validates :name, uniqueness: true

	

  def published_posts_count
    self.posts.where.not(published_at: nil).count
  end

end
