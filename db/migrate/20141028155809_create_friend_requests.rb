class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id, null: false
      t.integer :requested_id, null: false

      t.timestamps
    end
  end
end
