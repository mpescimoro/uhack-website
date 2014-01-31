class DestroyOrphanTags < ActiveRecord::Migration
  def change
  	Tag.all.each do |tag|
      tag.destroy if tag.posts.count == 0
    end
  end
end
