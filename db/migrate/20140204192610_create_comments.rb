class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commenter, polymorphic: true
      t.references :commentable, polymorphic: true

      t.timestamps
    end
    add_index :comments, :commenter_id
    add_index :comments, :commenter_type
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
