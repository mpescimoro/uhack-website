class AddProfileToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :description, :text
  	add_column :users, :image_url, :string

  	add_column :super_users, :description, :text
  	add_column :super_users, :image_url, :string
  end
end
