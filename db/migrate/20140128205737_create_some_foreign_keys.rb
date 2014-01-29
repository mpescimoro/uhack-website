class CreateSomeForeignKeys < ActiveRecord::Migration
  def change
    add_column :posts, :creator_id, :integer
    add_column :posts, :creator_type, :string
  end
end
