class Post < ActiveRecord::Base
  include Taggable

	belongs_to :creator, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :creator_id, presence: true

	def publish_date
		published_at.strftime('%d/%m/%Y')
	end

  def published?
    published_at ? true : false
  end

  def activity_date
    self.published_at
  end

  def commentable_root
    self
  end

end
