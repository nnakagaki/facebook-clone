class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friend_id, null: false
      t.integer :friended_id, null: false

      t.timestamps
    end
  end
end
