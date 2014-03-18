class ChangeProfileables < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :super_users, :name, :string
    add_column :super_users, :surname, :string
  end
end
