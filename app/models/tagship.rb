class Tagship < ActiveRecord::Base

	belongs_to :taggable, polymorphic:  true
	belongs_to :tag

	has_many :taggables, :through => :tagships, :source => 'Post'

end
