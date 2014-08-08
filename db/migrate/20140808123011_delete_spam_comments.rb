class DeleteSpamComments < ActiveRecord::Migration
  def up
    Comment.all.each do |comment|
      comment.destroy if comment.commenter.is_a? Guest
    end
  end

  def down
  end
end
