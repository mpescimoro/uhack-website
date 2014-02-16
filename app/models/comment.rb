class Comment < ActiveRecord::Base

	belongs_to :commenter, polymorphic: true
	belongs_to :commentable, polymorphic: true

	validates :commenter_id, presence: true
	validates :commentable_id, presence: true
  validates :body, presence: { message: 'campo obbligatorio' }

  def activity_date
    self.created_at
  end

end
