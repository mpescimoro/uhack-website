class Tag < ActiveRecord::Base

	has_many :tagships, dependent: :destroy
	has_many :posts, through: :tagships

	validates :name, uniqueness: true

end
