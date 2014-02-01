class AdjustTagshipForPolymorphic < ActiveRecord::Migration
  def change
  	add_column :tagships, :taggable_id, :integer
  	add_column :tagships, :taggable_type, :string
  	remove_column :tagships, :post_id, :integer
  end
end
