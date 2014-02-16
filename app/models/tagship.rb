class Tagship < ActiveRecord::Base

  before_destroy :destroy_orphan_tag

	belongs_to :taggable, polymorphic:  true
	belongs_to :tag

  private
  def destroy_orphan_tag
    self.tag.destroy if self.tag.tagships.count <= 1
  end

end
