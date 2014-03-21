class Tag < ActiveRecord::Base

	has_many :tagships
	has_many :posts, through: :tagships, source: :taggable, source_type: 'Post'
  has_many :users, through: :tagships, source: :taggable, source_type: 'User'
  has_many :super_users, through: :tagships, source: :taggable, source_type: 'SuperUser'

	validates :name, uniqueness: true

	

  def posts_count
    self.posts.where.not(published_at: nil).count
  end

  def tagships_count(type=nil)
    type ? self.tagships.where(taggable_type: type).count : self.tagships.count
  end

  def users_count
    self.users.count + self.super_users.count
  end

  def has_any?(taggable_type)
    self.send(taggable_type).count > 0
  end

end
