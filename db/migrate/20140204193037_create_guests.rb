class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :username
      t.string :email

      t.timestamps
    end
    add_index :guests, :username
    add_index :guests, :email
  end
end
