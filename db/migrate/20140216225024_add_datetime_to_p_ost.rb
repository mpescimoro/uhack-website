class AddDatetimeToPOst < ActiveRecord::Migration
  def change
    remove_column :posts, :published_at, :date
    add_column :posts, :published_at, :datetime
  end
end
