class Comment < ActiveRecord::Base

	belongs_to :commenter, polymorphic: true
	belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

	validates :commenter_id, presence: true
	validates :commentable_id, presence: true
  validates :body, presence: { message: 'campo obbligatorio' }

  def commentable_root
    c = self
    begin
      c = c.commentable
    end while c.respond_to? :commentable
  end

  def activity_date
    self.created_at
  end

end
